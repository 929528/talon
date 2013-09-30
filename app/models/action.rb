class Action < ActiveRecord::Base
	def issue?
		self.name == "issue"
	end

	def repaid?
		self.name == "repaid"
	end
end