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

	def issued?
		self.state.name == "issued"
	end

	def repaid?
		self.state.name == "repaid"
	end

	def new?
		self.state.name == "new"
	end
end