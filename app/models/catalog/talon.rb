class Catalog::Talon < ActiveRecord::Base

	belongs_to :amount
	belongs_to :state
	belongs_to :product
	has_many :operations

	VALID_BARCODE_REGEX = /\A[2,5][1-6]\d{8}\z/
	validates :barcode, presence: true, uniqueness: true, format: { with: VALID_BARCODE_REGEX }
	validate :correct_state

	before_save :change_state, if: :write?

	def initialize attributes = {}
		super
		self.amount ||= Catalog::Amount.find_by_symbol(self.barcode[0]) if self.new_record?
		self.product ||= Catalog::Product.find_by_symbol(self.barcode[1]) if self.new_record?
		self.state ||= Catalog::State.find_by_name("new") if self.new_record?	
	end

	def action= action
		@action = action
	end
	def new_state
		@new_state ||= get_new_state
	end
	def get_new_state
		case @action.name
		when 'issue'
			Catalog::State.find_by_name 'issued'
		when 'repaid'
			Catalog::State.find_by_name 'repaid'
		end
	end

	def change_state
		self.state = self.new_state
	end

	def write= val
		@write = val
	end
	def write?
		@write ||= false
	end
	def issued?
		self.state.issued?
	end
	private

	def correct_state
		errors[:base] << "Талон #{self.barcode} выдан" if self.state.issued? && new_state.issued?
		errors[:base] << "Талон #{self.barcode} погашен" if self.state.repaid? && new_state.repaid?
		errors[:base] << "Талон #{self.barcode} не выдан" if self.state.new? && new_state.repaid?
	end
end