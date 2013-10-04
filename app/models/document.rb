class Document < ActiveRecord::Base
	belongs_to :contract, class_name: 'Catalog::Contract'
	has_one :customer, through: :contract
	belongs_to :department, class_name: 'Catalog::Department'
	has_one :organization, through: :department
	belongs_to :state
	belongs_to :type
	belongs_to :user, class_name: 'Catalog::User'
	has_many :operations, dependent: :destroy, inverse_of: :document

	accepts_nested_attributes_for :operations

	validates_presence_of :department, :operations
	validates_presence_of :contract, if: :issue?
	validate :correct_new_state
	validate :correct_operations, unless: :has_errors?

	before_save :change_talons_state, if: :correct_state_change?

	def initialize attributes = {}
		super
		self.state ||= State.find_by_name 'new' if self.new_record?
	end

	def issue?
		self.type.issue?
	end
	def repaid?
		self.type.repaid?
	end
	def customer_name
		self.contract.customer.name
	end
	def new_state
		@new_state ||= State.find_by_name('new').name
	end
	def new_state= val
		@new_state = State.find_by_name val
	end

	private

	def correct_new_state
		errors[:base] << 'Документ уже проведен' if new_state.write? && self.state.write?
		errors[:base] << 'Документ проведен' if new_state.save? && self.state.write?
		errors[:base] << 'Ошибка состояний' if new_state.new?
	end
	def correct_operations
		self.operations.each do |operation|
			errors[:base] << "#{operation.errors.full_messages.to_sentence}" unless operation.valid?
		end
	end
	def has_errors?
		errors.any?
	end
	def change_state
		self.state = new_state
	end
	def correct_state_change?
		true if change_state && self.state.write?
	end
	def change_talons_state
		self.operations.each do |operation|
			operation.talon.update_attributes write: true
		end
	end
end