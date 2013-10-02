class RemoveCustomerRefFromDocuments < ActiveRecord::Migration
  def change
    remove_reference :documents, :customer, index: true
  end
end
