class CreateTalons < ActiveRecord::Migration
  def change
    create_table :talons do |t|
      t.string :amount
      t.string :barcode
      t.references :product
      t.references :state

      t.timestamps
    end
    add_index :talons, :product_id
    add_index :talons, :state_id
  end
end
