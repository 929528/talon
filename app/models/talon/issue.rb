class Talon::Issue < Document::Document
  belongs_to :department, class_name: "Catalog::Department"
  belongs_to :contract, class_name: "Catalog::Contract"
  belongs_to :user, class_name: "Catalog::User"
  belongs_to :state, class_name: "Document::State"
  has_many :operations, as: :document, class_name: "Talon::Action::Issue"
  accepts_nested_attributes_for :operations

  validates_presence_of :contract, :operations

  def customer_name
    self.contract.customer.name
  end
  def set_state
    super
    if self.state.write?
      self.operations.each {|operation| operation.talon.change_state}
    end
  end
end