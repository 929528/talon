class CreateCatalogAmounts < ActiveRecord::Migration
  def change
    create_table :catalog_amounts do |t|
      t.integer :value
      t.string :symbol

      t.timestamps
    end
  end
end
