class Talon::State < ActiveRecord::Base
	def issued?
		self.name == "issued"
	end
	def repaid?
		self.name == "repaid"
	end
	def new?
		self.name == "new"
	end
end
