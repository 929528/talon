class AddDepartmentRefToUsers < ActiveRecord::Migration
  def change
    add_reference :catalog_users, :department, index: true
  end
end
