class Catalog::Department < ActiveRecord::Base
	belongs_to :organization
	has_many :documents

	validates_presence_of :name

	after_initialize do |department|
		department.organization ||= department.build_organization if department.new_record?
	end
end
