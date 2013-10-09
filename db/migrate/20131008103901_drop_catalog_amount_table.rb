class DropCatalogAmountTable < ActiveRecord::Migration
  def change
  	drop_table :catalog_amounts
  end
end
