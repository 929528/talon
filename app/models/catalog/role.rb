class Catalog::Role < ActiveRecord::Base
  has_many :users

  validates :name , presence: true, length: {maximum: 20, minimum: 4}, uniqueness: true
end
