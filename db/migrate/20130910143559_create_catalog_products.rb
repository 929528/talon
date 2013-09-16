class CreateCatalogProducts < ActiveRecord::Migration
  def change
    create_table :catalog_products do |t|
      t.string :name
      t.string :fullname
      t.integer :symbol

      t.timestamps
    end
  end
end
