class Catalog::Product < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
	validates :symbol, presence: true, uniqueness: true

	before_save :set_fullname

	def current_price
	end
	def current_price=
	end

	protected

	def set_fullname
		self.fullname = self.name if self.fullname.blank?
	end
end