class Talon::Repaid < ActiveRecord::Base
	belongs_to :department, class_name: "Catalog::Department"
	belongs_to :user, class_name: "Catalog::User"
	belongs_to :state, class_name: "Document::State"
	has_many :operations, as: :document, autosave: true

	validates_presence_of :operations
	validate :correct_new_state
	validate :correct_operations, unless: "self.errors.any?"


	before_save :set_state
	accepts_nested_attributes_for :operations


	def initialize attributes = {}
		super
		self.state ||= Document::State.find_by_name "new" if self.new_record?
	end
	def new_state
		@new_state ||= self.state.name
	end
	def new_state= name
		@new_state = Document::State.find_by_name name
	end

	private

	def correct_new_state
		errors[:base] << "Документ уже проведен" if self.state.write? && new_state.write?
		errors[:base] << "Документ проведен, запись невозможна" if self.state.write? && new_state.save?
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
	def set_state
		self.state = new_state
		if self.state.write?
			self.operations.each {|operation| operation.talon.change_state}
		end
	end
	def get_last_document_string_on operation
		last_document = Talon::Repaid.where(state: Document::State.find_by_name("write")).joins(:operations).
		where(talon_operations: {action_id: operation.action.id, talon_id: operation.talon.id}).order("updated_at").last
		string = " документом № #{last_document.id} #{last_document.updated_at.strftime "от %d/%m/%Y-%H:%M"}"
	end
end
