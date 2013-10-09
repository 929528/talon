class Catalog::Department < ActiveRecord::Base
  belongs_to :organization
end
