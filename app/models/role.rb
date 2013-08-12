class Role < ActiveRecord::Base
  attr_accessible :name

  has_many :user

  validates :name , presence: true, length: {maximum: 20, minimum: 4}, uniqueness: true
end
