class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.datetime :date
      t.references :customer
      t.references :organization
      t.references :actionstate

      t.timestamps
    end
    add_index :documents, :customer_id
    add_index :documents, :organization_id
    add_index :documents, :actionstate_id
  end
end
