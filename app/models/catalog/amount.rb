class Catalog::Amount < ActiveRecord::Base
	validates_presence_of :value, :symbol
end