class DelColumnFromTables < ActiveRecord::Migration
 def change
 	remove_column :roles, :user_id
 	remove_column :departments, :user_id
 	remove_column :organizations, :user_id
 	remove_column :organizations, :department_id
 end
end
