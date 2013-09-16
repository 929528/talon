class AddDocumentStateToDocument < ActiveRecord::Migration
  def change
    add_reference :documents, :DocumentState, index: true
  end
end
