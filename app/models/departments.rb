class Departments < ActiveRecord::Base
  attr_accessible :name
  belongs_to :organization

  validates :name , presence: true, length: {maximum: 50, minimum: 4}
end
