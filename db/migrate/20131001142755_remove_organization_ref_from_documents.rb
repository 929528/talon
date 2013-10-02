class RemoveOrganizationRefFromDocuments < ActiveRecord::Migration
  def change
    remove_reference :documents, :organization, index: true
  end
end
