class Catalog::Customer < ActiveRecord::Base
	has_many :contracts, inverse_of: :customer, dependent: :destroy
	has_many :documents, through: :contracts

	validates :name, presence: true, uniqueness: true
	validates :contracts, presence: true

	accepts_nested_attributes_for :contracts

	before_save :set_fullname

	protected

	def set_fullname
		self.fullname = self.name if self.fullname.blank?
	end
end
