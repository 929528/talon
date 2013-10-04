class Catalog::State < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
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
