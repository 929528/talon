class AddContractRefToDocument < ActiveRecord::Migration
  def change
    add_reference :documents, :contract, index: true
  end
end
