class CreateTalonRepaids < ActiveRecord::Migration
  def change
    create_table :talon_repaids do |t|
      t.references :department, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
