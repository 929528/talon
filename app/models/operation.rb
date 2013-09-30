class Operation < ActiveRecord::Base

	belongs_to :document, inverse_of: :operations
	belongs_to :talon, class_name: "Catalog::Talon", validate: true
	belongs_to :action

	validate :correct_talon_state

	before_save do |operation|
		self.talon.update_attributes(state: get_new_talon_state_on(self.action)) if operation.write?
	end

	after_initialize do |operation|
		@state = "new"
	end

	def talon_barcode
		self.talon.barcode
	end
	def talon_barcode= barcode
		self.talon = Catalog::Talon.find_or_initialize_by(barcode: barcode) 
	end
	def state= state
		@state = state
	end
	def state
		@state
	end
	def write?
		state == "write"
	end

	def get_new_talon_state_on action
		case action.name
		when "issue" then Catalog::State.find_by_name "issued"
		when "repaid" then Catalog::State.find_by_name "repaid"
		end
	end

	private

	def correct_talon_state
		case self.action.name
		when "issue" 
			if self.talon.issued?
				last_document = Document.where(state: State.find_by_name("write")).
				joins(:operations).where(operations: {talon: self.talon, action: self.action}).order("updated_at").last
				errors[:base] << "Талон #{self.talon.barcode} выдан документом 
				№ #{last_document.id} от #{last_document.updated_at.strftime "%d/%m/%Y в %H:%M"}" 
			end
		when "repaid"
			if self.talon.repaid?
				last_document = Document.where(state: State.find_by_name("write")).
				joins(:operations).where(operations: {talon: self.talon, action: self.action}).order("updated_at").last
				errors[:base] << "Талон #{self.talon.barcode} погашен документом 
				№ #{last_document.id} от #{last_document.updated_at.strftime "%d/%m/%Y в %H:%M"}" 
			end
			errors[:base] << "Талон #{self.talon.barcode} не выдан" if self.talon.new?
		end
	end
end