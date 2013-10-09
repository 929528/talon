class CreateTalonStates < ActiveRecord::Migration
  def change
    create_table :talon_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
