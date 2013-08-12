class Organizations < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  has_many :department

  validates :name , presence: true, length: {maximum: 50, minimum: 4}, uniqueness: true
end
