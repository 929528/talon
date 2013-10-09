class CreateTalonIssues < ActiveRecord::Migration
  def change
    create_table :talon_issues do |t|
      t.references :department, index: true
      t.references :contract, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
