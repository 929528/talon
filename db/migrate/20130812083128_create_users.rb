class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :organization_id
      t.integer :department_id
      t.integer :role_id

      t.timestamps
    end
  end
end
