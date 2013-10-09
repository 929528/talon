class Talon::Issue < ActiveRecord::Base
  belongs_to :department, class_name: "Catalog::Department"
  belongs_to :contract, class_name: "Catalog::Contract"
  belongs_to :user, class_name: "Catalog::User"
  belongs_to :state, class_name: "Document::State"
  has_many :operations, as: :document, autosave: true

  validates_presence_of :contract, :operations
  validate :correct_new_state
  validate :correct_operations, unless: "self.errors.any?"


  before_save :set_state
  accepts_nested_attributes_for :operations


  def initialize attributes = {}
  	super
  	self.state ||= Document::State.find_by_name "new" if self.new_record?
  end
  def customer_name
    self.contract.customer.name
  end
  def new_state
  	@new_state ||= self.state.name
  end
  def new_state= name
  	@new_state = Document::State.find_by_name name
  end

  private

  def correct_new_state
    errors[:base] << "Документ уже проведен" if self.state.write? && new_state.write?
    errors[:base] << "Документ проведен, запись невозможна" if self.state.write? && new_state.save?
  end

  def correct_operations
    self.operations.each do |operation|
      unless operation.valid?
        operation.errors.full_messages.each do |msg|
          errors[:base] << "#{msg}"
        end
      end
    end
  end
  def set_state
    self.state = new_state
    if self.state.write?
      self.operations.each {|operation| operation.talon.change_state}
    end
  end
end