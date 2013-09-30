class RenameDocumentStateToState < ActiveRecord::Migration
  def change
  	rename_table :document_states, :states
  end
end
