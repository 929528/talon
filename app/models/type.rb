class Type < ActiveRecord::Base
	def issue?
		self.name == 'issue_talons'
	end
	def repaid?
		self.name == 'repaid_talons'
	end
end
