class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.references :document
      t.references :actionstate
      t.references :talon

      t.timestamps
    end
    add_index :operations, :document_id
    add_index :operations, :actionstate_id
    add_index :operations, :talon_id
  end
end
