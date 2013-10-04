class Operation < ActiveRecord::Base

	belongs_to :document, inverse_of: :operations
	belongs_to :talon, class_name: 'Catalog::Talon'
	belongs_to :action

	validates_presence_of :talon
	validate :correct_talon_state

	after_initialize do |operation| 
		operation.talon.action = operation.action
	end

	def document_type= type
		case type.name
		when 'issue_talons' then self.action = Action.find_by_name 'issue'
		when 'repaid_talons' then self.action = Action.find_by_name 'repaid'
		end
	end
	def talon_barcode= barcode
		self.talon = Catalog::Talon.find_or_initialize_by(barcode: barcode)
	end
	def talon_barcode
		self.talon.barcode
	end

	private

	def correct_talon_state
		unless self.talon.valid?
			last_document = Document.where(state: State.find_by_name("write")).
			joins(:operations).where(operations: {action: self.action, talon: self.talon}).order("updated_at").last 
			document_string = " документом № #{last_document.id} #{last_document.updated_at.strftime "от %d/%m/%Y-%H:%M"}" unless last_document.nil?
			self.talon.errors.full_messages.each do |msg|
				errors[:base] << "#{msg} #{document_string}"
			end
		end
	end
end