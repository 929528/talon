class State < ActiveRecord::Base
	def save?
		self.name == 'save'
	end
	def write?
		self.name == 'write'
	end
	def new?
		self.name == 'new'
	end
end
