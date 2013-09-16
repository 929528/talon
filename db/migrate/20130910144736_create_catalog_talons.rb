class CreateCatalogTalons < ActiveRecord::Migration
  def change
    create_table :catalog_talons do |t|
      t.references :amount, index: true
      t.references :state, index: true
      t.references :product, index: true
      t.string :barcode

      t.timestamps
    end
    add_index :catalog_talons, :barcode
  end
end
