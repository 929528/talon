class Organization < ActiveRecord::Base
	attr_accessible :name, :fullname, :departments_attributes
	has_many :departments
	accepts_nested_attributes_for :departments, :reject_if => :all_blank, :allow_destroy => true

	before_save :set_fullname
	
	validates :name , presence: true, length: {maximum: 50, minimum: 4}, uniqueness: true

	default_scope order: 'organizations.created_at DESC'

	private

	def set_fullname
		self.fullname = self.name if self.fullname.nil?
	end
end