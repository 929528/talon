class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.references :document, index: true
      t.references :talon, index: true
      t.references :action, index: true

      t.timestamps
    end
  end
end
