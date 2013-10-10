class Catalog::Talon < ActiveRecord::Base

	belongs_to :amount, class_name: "Talon::Amount"
	belongs_to :state, class_name: "Talon::State"
	belongs_to :product

	VALID_BARCODE_REGEX = /\A[2,5][1-5]\d{8}\z/
	validates :barcode, presence: true, uniqueness: true, format: { with: VALID_BARCODE_REGEX }

	def initialize attributes = {}
		super
		self.amount ||= Talon::Amount.find_by_symbol(self.barcode[0]) if self.new_record?
		self.product ||= Catalog::Product.find_by_symbol(self.barcode[1]) if self.new_record?
		self.state ||= Talon::State.find_by_name("new") if self.new_record?	
	end
	def issued?
		self.state.issued?
	end
	def repaid?
		self.state.repaid?
	end
	def new?
		self.state.new?
	end
	def action= action
		case action.name
		when "issue"
			@new_state = Talon::State.find_by_name "issued"
		when "repaid"
			@new_state = Talon::State.find_by_name "repaid"
		end
	end
	def new_state
		@new_state
	end
	def change_state
		self.update_attributes state: new_state
	end
end