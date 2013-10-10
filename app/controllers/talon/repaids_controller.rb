class Talon::RepaidsController < Talon::DocumentController
	before_filter :init_document

	def new_operation
		super Talon::Action::Repaid
	end

	private
	
	def init_document
		self.target = Talon::Repaid
	end
end