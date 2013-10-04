class AddTypeRefToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :type, index: true
  end
end
