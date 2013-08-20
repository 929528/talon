class Department < ActiveRecord::Base
  attr_accessible :name, :fullname

  belongs_to :organization

  before_save :set_fullname

  validates :name , presence: true, length: {maximum: 50, minimum: 4}

  private

  def set_fullname
  	self.fullname = self.name if self.fullname.nil?
  end

end
