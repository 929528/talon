class CreateTalonAmounts < ActiveRecord::Migration
  def change
    create_table :talon_amounts do |t|
      t.integer :value
      t.integer :symbol

      t.timestamps
    end
  end
end
