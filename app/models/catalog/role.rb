class Catalog::Role < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
end
