class Catalog::Contract < ActiveRecord::Base
	belongs_to :customer, inverse_of: :contracts
	has_many :documents

	validates_presence_of :name
end
