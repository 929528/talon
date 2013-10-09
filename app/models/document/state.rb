class Document::State < ActiveRecord::Base
	def write?
		self.name == "write"
	end
	def save?
		self.name == "save"
	end
end
