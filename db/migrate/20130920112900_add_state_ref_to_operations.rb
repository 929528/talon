class AddStateRefToOperations < ActiveRecord::Migration
  def change
    add_reference :operations, :state, index: true
  end
end
