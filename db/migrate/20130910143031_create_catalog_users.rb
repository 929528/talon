class CreateCatalogUsers < ActiveRecord::Migration
  def change
    create_table :catalog_users do |t|
      t.string :name
      t.string :fullname
      t.string :email
      t.string :password_digest
      t.string :remember_token
      t.references :role, index: true

      t.timestamps
    end
    add_index :catalog_users, :name
    add_index :catalog_users, :email
  end
end
