class AddFullnameToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :fullname, :string
  end
end
