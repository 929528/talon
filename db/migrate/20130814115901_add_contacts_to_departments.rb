class AddContactsToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :responsible, :string
    add_column :departments, :address, :string
    add_column :departments, :phone, :string
  end
end
