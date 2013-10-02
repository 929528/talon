class Document < ActiveRecord::Base
	belongs_to :contract, class_name: "Catalog::Contract"
	has_one :customer, through: :contract
	belongs_to :department, class_name: "Catalog::Department"
	has_one :organization, through: :department
	belongs_to :state
	belongs_to :action
	has_many :operations, dependent: :destroy, inverse_of: :document
	accepts_nested_attributes_for :operations

	after_initialize do |document|
		document.state ||= State.find_by_name("new") if document.new_record?
	end

	validates_presence_of :operations, :contract, :department

	validate :correct_new_state
	validate :correct_operations, unless: :errors? && :write?
	before_save :perform_document

	def new_document_state_name= name
		@new_state = State.find_by_name name
	end
	def new_state
		@new_state
	end
	def new_document_state_name
		State.find_by_name("new")
	end
	def organization_name
		self.department.organization.name
	end
	def customer_name
		self.contract.customer.name
	end
	def write?
		self.state.name == "write"
	end
	def errors= bool
		@errors = bool
	end
	def errors?
		@errors
	end

	private

	def correct_new_state
		case self.state.name
		when "write"
			errors[:base] << "Документ проведен" if new_state.name == "save"
			errors[:base] << "Документ проведен" if new_state.name == "write"
		end
		errors= true if self.errors.any?
	end

	def perform_document
		self.state = new_state
		self.operations.each {|operation| operation.perform self.state}
	end

	def correct_operations
		self.operations.each do |operation|
			errors[:base] << "#{operation.errors.full_messages.to_sentence}" unless operation.valid?
		end
		errors= true if self.errors.any?
	end
end