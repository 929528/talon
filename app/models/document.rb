class Document < ActiveRecord::Base
	belongs_to :customer, class_name: "Catalog::Customer"
	belongs_to :organization, class_name: "Catalog::Organization"
	belongs_to :state, class_name: "DocumentState",  foreign_key: "DocumentState_id"
	belongs_to :action
	has_many :operations, dependent: :destroy

	after_initialize :document_initialize

	protected

	def document_initialize
		self.state ||= DocumentState.find_by_name("new") if self.new_record?
	end
end