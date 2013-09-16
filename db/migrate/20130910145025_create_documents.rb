class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :customer, index: true
      t.references :organization, index: true
      t.references :action, index: true

      t.timestamps
    end
  end
end
