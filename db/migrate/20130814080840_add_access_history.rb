class AddAccessHistory < ActiveRecord::Migration
  def change
  	create_table :access_history do |t|
  		t.integer :user_id
  		t.string :adress
  	end
  end
end
