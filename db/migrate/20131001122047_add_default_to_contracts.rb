class AddDefaultToContracts < ActiveRecord::Migration
  def change
    add_column :catalog_contracts, :default, :boolean
  end
end
