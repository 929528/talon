class Catalog::Amount < ActiveRecord::Base
	validates :value, presence: true
	validates :symbol, presence: true
end
