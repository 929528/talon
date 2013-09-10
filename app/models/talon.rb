class Talon < ActiveRecord::Base
  belongs_to :product
  belongs_to :state
end
