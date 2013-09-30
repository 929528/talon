class RenameDocumentStateRefToStateOnDocuments < ActiveRecord::Migration
  def change
  	change_table :documents do |t|
  		t.rename :DocumentState_id, :state_id
  	end
  end
end
