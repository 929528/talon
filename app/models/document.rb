class Document < ActiveRecord::Base
	belongs_to :customer
	belongs_to :organization
	belongs_to :actionstate
	has_many :operations

	accepts_nested_attributes_for :operations
end