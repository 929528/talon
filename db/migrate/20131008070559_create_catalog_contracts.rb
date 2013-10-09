class CreateCatalogContracts < ActiveRecord::Migration
  def change
    create_table :catalog_contracts do |t|
      t.string :name
      t.string :fullname
      t.boolean :default
      t.references :customer, index: true

      t.timestamps
    end
  end
end
