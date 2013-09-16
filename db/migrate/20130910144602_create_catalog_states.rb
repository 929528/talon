class CreateCatalogStates < ActiveRecord::Migration
  def change
    create_table :catalog_states do |t|
      t.string :name

      t.timestamps
    end
  end
end
