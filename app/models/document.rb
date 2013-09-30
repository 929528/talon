class Document < ActiveRecord::Base
	belongs_to :customer, class_name: "Catalog::Customer", inverse_of: :documents
	belongs_to :organization, class_name: "Catalog::Organization"
	belongs_to :state
	belongs_to :action
	has_many :operations, dependent: :destroy, inverse_of: :document, validate: true
	belongs_to :contract, class_name: "Catalog::Contract"
	accepts_nested_attributes_for :operations

	after_initialize do |document|
		document.state ||= State.find_by_name("new") if document.new_record?
	end

	validates_presence_of :operations
	# validates :customer, presence: true

	before_validation do |document|
		document.operations.each {|operation| operation.state = new_state.name}
	end
	validate :correct_new_state
	validate :correct_operations, unless: :errors? && :write?
	before_save :perform_document

	def customer_name= name
		self.customer = Catalog::Customer.find_by_name name
	end
	def customer_name
		self.customer.name
	end
	def new_document_state_name= name
		@new_state = State.find_by_name name
	end
	def new_state
		@new_state
	end
	def new_document_state_name
		State.find_by_name("new")
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
	end

	def correct_operations
		self.operations.each do |operation|
			errors[:base] << "#{operation.errors.full_messages.to_sentence}" unless operation.valid?
		end
	end
end