class AddDepartmentRefToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :department, index: true
  end
end
