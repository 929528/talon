class AddRefToContracts < ActiveRecord::Migration
  def change
    add_reference :catalog_contracts, :customer, index: true
  end
end