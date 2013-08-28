class CreateProducts < ActiveRecord::Migration
	def change
		create_table :products do |t|
			t.string :name
			t.string :fullname
			t.float :price
			t.string :idsymbol

			t.timestamps
		end
	end
end
