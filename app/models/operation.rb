class Operation < ActiveRecord::Base
	belongs_to :document
	belongs_to :talon, class_name: "Catalog::Talon", validate: true
	belongs_to :action

	after_initialize :operation_initialize

	protected

	def operation_initialize
		self.action ||= Action.find_by_name("new") if self.new_record?
	end
end