class CreateCatalogCustomers < ActiveRecord::Migration
  def change
    create_table :catalog_customers do |t|
      t.string :name
      t.string :fullname

      t.timestamps
    end
    add_index :catalog_customers, :name
  end
end
