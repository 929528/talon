class CreateCatalogRoles < ActiveRecord::Migration
  def change
    create_table :catalog_roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
