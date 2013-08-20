class RemoveColumnFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :organization_id
    remove_column :users, :department_id
  end
end
