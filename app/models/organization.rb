class Organization < ActiveRecord::Base
	attr_accessible :name, :fullname

	has_many :department
	has_many :user

	before_save :set_fullname
	before_save :set_def_department
	
	validates :name , presence: true, length: {maximum: 50, minimum: 4}, uniqueness: true

	private

	def set_def_department
		self.department.new(name:"default") if !self.department.any? 
	end

	def set_fullname
		self.fullname = self.name if self.fullname.nil?
	end
end