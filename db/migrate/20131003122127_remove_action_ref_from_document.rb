class RemoveActionRefFromDocument < ActiveRecord::Migration
  def change
    remove_reference :documents, :action, index: true
  end
end
