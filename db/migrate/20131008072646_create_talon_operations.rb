class CreateTalonOperations < ActiveRecord::Migration
  def change
    create_table :talon_operations do |t|
      t.references :talon, index: true
      t.decimal :price
      t.references :document, polymorphic: true, index: true

      t.timestamps
    end
  end
end
