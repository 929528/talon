class Roles < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user

  validates :name , presence: true, length: {maximum: 20, minimum: 4}, uniqueness: true
end
