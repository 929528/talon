class Talon::IssuesController < Talon::DocumentController
	before_filter :init_document

	def new_operation
		super Talon::Action::Issue
	end

	private
	
	def init_document
		self.target = Talon::Issue
	end
end