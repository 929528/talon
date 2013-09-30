class RemoveStateRefFromOperations < ActiveRecord::Migration
	def change
		change_table :operations do |t|
			t.remove :state_id
		end
	end
end
