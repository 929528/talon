class Department < ActiveRecord::Base
  attr_accessible :name

  belongs_to :organization
  has_many :user

  validates :name , presence: true, length: {maximum: 50, minimum: 4}
end
