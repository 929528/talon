class AddOrganizationRefToDepartments < ActiveRecord::Migration
  def change
    add_reference :catalog_departments, :organization, index: true
  end
end
