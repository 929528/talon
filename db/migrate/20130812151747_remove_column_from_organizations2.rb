class RemoveColumnFromOrganizations2 < ActiveRecord::Migration
	def change
		remove_column :organizations, :department_id
	end
end