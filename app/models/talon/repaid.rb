class Talon::Repaid < Document::Document
	belongs_to :department, class_name: "Catalog::Department"
	belongs_to :user, class_name: "Catalog::User"
	belongs_to :state, class_name: "Document::State"
	has_many :operations, as: :document, class_name: "Talon::Action::Repaid"
	accepts_nested_attributes_for :operations
	validates_presence_of :operations

	def set_state
		super
		if self.state.write?
			self.operations.each {|operation| operation.talon.change_state}
		end
	end
end