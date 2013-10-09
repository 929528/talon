class AddActionRefToTalonOperations < ActiveRecord::Migration
  def change
    add_reference :talon_operations, :action, index: true
  end
end
