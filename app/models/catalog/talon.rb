class Catalog::Talon < ActiveRecord::Base
	belongs_to :amount
	belongs_to :state
	belongs_to :product

	VALID_BARCODE_REGEX = /\A[2,5][1-6]\d{8}\z/
	validates :barcode, presence: true, uniqueness: true, format: { with: VALID_BARCODE_REGEX }

	after_initialize :talon_initialize

	protected

	def talon_initialize
		self.amount ||= Catalog::Amount.find_by_symbol(self.barcode[0]) if self.new_record?
		self.product ||= Catalog::Product.find_by_symbol(self.barcode[1]) if self.new_record?
	end
end