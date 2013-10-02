class Catalog::Organization < ActiveRecord::Base
	has_many :departments, inverse_of: :organization, dependent: :destroy
	has_many :documents, through: :departments

	validates :name, presence: true, uniqueness: true
	validates_presence_of :departments

	accepts_nested_attributes_for :departments

	before_save :set_fullname

	protected

	def set_fullname
		self.fullname = self.name if self.fullname.blank?
	end
end
