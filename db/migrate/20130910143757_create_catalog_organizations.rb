class CreateCatalogOrganizations < ActiveRecord::Migration
  def change
    create_table :catalog_organizations do |t|
      t.string :name
      t.string :fullname

      t.timestamps
    end
    add_index :catalog_organizations, :name
  end
end
