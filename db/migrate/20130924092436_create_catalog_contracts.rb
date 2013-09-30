class CreateCatalogContracts < ActiveRecord::Migration
  def change
    create_table :catalog_contracts do |t|
      t.string :name

      t.timestamps
    end
  end
end
