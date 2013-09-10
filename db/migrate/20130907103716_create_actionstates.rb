class CreateActionstates < ActiveRecord::Migration
  def change
    create_table :actionstates do |t|
      t.string :name

      t.timestamps
    end
  end
end
