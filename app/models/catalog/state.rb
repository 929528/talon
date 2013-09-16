class Catalog::State < ActiveRecord::Base
	validates :name, presence: true, uniqueness: true
end
