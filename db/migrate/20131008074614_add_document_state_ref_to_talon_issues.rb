class AddDocumentStateRefToTalonIssues < ActiveRecord::Migration
  def change
    add_reference :talon_issues, :state, index: true
  end
end
