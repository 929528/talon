class Catalog::Contract < ActiveRecord::Base
	belongs_to :customer, inverse_of: :contracts
	has_many :documents

	validates_presence_of :name

	after_initialize do |contract|
		contract.customer ||= contract.build_customer if contract.new_record?
	end
end
