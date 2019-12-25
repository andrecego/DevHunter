class CreateApprovals < ActiveRecord::Migration[6.0]
  def change
    create_table :approvals do |t|
      t.date :start_date
      t.integer :wage
      t.text :aid
      t.references :inscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
