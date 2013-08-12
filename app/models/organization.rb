class Organization < ActiveRecord::Base
	attr_accessible :name

	has_many :department
	has_many :user

	before_save :set_def_department

	validates :name , presence: true, length: {maximum: 50, minimum: 4}, uniqueness: true

	def set_def_department
		if !self.department.any? 
			self.department.new(name:"default");
		end
	end
end