class AddFullnameToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations, :fullname, :string
  end
end
