class CreateTalonActions < ActiveRecord::Migration
  def change
    create_table :talon_actions do |t|
      t.string :name

      t.timestamps
    end
  end
end
