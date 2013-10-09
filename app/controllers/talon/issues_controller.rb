class Talon::IssuesController < Talon::DocumentController
	before_filter :init_document

	private
	
	def init_document
		self.target = Talon::Issue
	end
end