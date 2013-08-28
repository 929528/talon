class Product < ActiveRecord::Base
	attr_accessible :name, :fullname

	before_save :set_fullname
	
	validates :name , presence: true, length: {maximum: 50, minimum: 4}, uniqueness: true

	default_scope order: 'products.created_at DESC'

	private

	def set_fullname
		self.fullname = self.name if self.fullname.blank?
	end
end