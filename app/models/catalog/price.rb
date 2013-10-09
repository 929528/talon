class Catalog::Price < ActiveRecord::Base
  belongs_to :department
  belongs_to :product
  belongs_to :user
end
