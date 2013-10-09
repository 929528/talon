class AddDocumentStateRefToTalonRepaids < ActiveRecord::Migration
  def change
    add_reference :talon_repaids, :state, index: true
  end
end
