class Catalog::Department < ActiveRecord::Base
	belongs_to :organization
	has_many :documents

	validates_presence_of :name
end
