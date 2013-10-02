class Catalog::Talon < ActiveRecord::Base

	belongs_to :amount
	belongs_to :state
	belongs_to :product
	has_many :operations

	after_initialize do |talon|
		self.amount ||= Catalog::Amount.find_by_symbol(self.barcode[0]) if self.new_record?
		self.product ||= Catalog::Product.find_by_symbol(self.barcode[1]) if self.new_record?
		self.state ||= Catalog::State.find_by_name("new") if self.new_record?		
	end

	VALID_BARCODE_REGEX = /\A[2,5][1-6]\d{8}\z/
	validates :barcode, presence: true, uniqueness: true, format: { with: VALID_BARCODE_REGEX }

	validate :correct_new_state

	before_save :change_state, if: :write?

	def issued?
		self.state.name == "issued"
	end

	def repaid?
		self.state.name == "repaid"
	end

	def new?
		self.state.name == "new"
	end
	def set_new_state
		self.update_attributes state: new_state
	end

	def set_new_state_on action 
		case action.name
		when "issue" then @new_state = Catalog::State.find_by_name "issued"
		when "repaid" then @new_state = Catalog::State.find_by_name "repaid"
		end
	end
	def new_state
		@new_state
	end
	def change_state
		self.state = new_state
	end
	def write?
		@write
	end
	def write= bool
		@write = bool
	end

	private

	def correct_new_state
		case new_state.name
		when "issued" 
			errors[:base] << "Талон #{self.barcode} выдан " if self.issued?
		when "repaid"
			errors[:base] << "Талон #{self.barcode} списан " if self.repaid?
			errors[:base] << "Талон не выдан " if self.new?
		end
	end
end