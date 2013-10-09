class DropCatalogStateTable < ActiveRecord::Migration
  def change
  	drop_table :catalog_states
  end
end
