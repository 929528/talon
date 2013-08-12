class AddRelations < ActiveRecord::Migration
	def change
		add_column :organizations, :department_id, :integer
		add_column :departments, :organization_id, :integer
		add_column :roles, :user_id, :integer
	end
end
