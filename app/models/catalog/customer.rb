class Catalog::Customer < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true

	before_save :set_fullname

	protected

	def set_fullname
		self.fullname = self.name if self.fullname.blank?
	end
end
