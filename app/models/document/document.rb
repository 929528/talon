class Document::Document < ActiveRecord::Base
	self.abstract_class = true
	after_initialize {|document| document.state ||= Document::State.find_by_name "new" if document.new_record?}
	validate :correct_new_state
	validate :correct_operations, unless: "self.errors.any?"
	before_save :set_state
	def new_state
		@new_state ||= self.state.name
	end
	def new_state= name
		@new_state = Document::State.find_by_name name
	end
	def correct_new_state
		errors[:base] << "Документ уже проведен" if self.state.write? && new_state.write?
		errors[:base] << "Документ проведен, запись невозможна" if self.state.write? && new_state.save?
	end
	def set_state
		self.state = new_state
	end
	def correct_operations
		self.operations.each do |operation|
			unless operation.valid?
				operation.errors.full_messages.each do |msg|
					errors[:base] << "#{msg}"
				end
			end
		end
	end
end