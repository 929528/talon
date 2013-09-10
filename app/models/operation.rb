class Operation < ActiveRecord::Base
	belongs_to :document
	belongs_to :actionstate
	belongs_to :talon
end
