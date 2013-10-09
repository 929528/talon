class Talon::RepaidsController < Talon::DocumentController
	before_filter :init_document

	private
	
	def init_document
		self.target = Talon::Repaid
	end
end