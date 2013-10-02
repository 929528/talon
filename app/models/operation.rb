class Operation < ActiveRecord::Base

	belongs_to :document, inverse_of: :operations
	belongs_to :talon, class_name: "Catalog::Talon"
	belongs_to :action

	after_initialize do |operation|
		operation.talon.set_new_state_on operation.action
	end

	validate :correct_talon_state

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

	def perform state
		self.talon.update_attributes(write: true) if state.name == "write"
	end

	private

	def correct_talon_state
		unless self.talon.valid?
			if 	last_document = Document.where(state: State.find_by_name("write")).
				joins(:operations).where(operations: {action: self.action, talon: self.talon}).order("updated_at").last 
				document_string = "документом № #{last_document.id} #{last_document.updated_at.strftime "от %d/%m/%Y-%H:%M"}" 
			end
			
			self.talon.errors.full_messages.each do |msg|
				errors[:base] << "#{msg}"+"#{document_string}"
			end
		end
	end
end