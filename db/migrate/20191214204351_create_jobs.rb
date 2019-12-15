class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.text :skills
      t.integer :position, default: 0
      t.integer :min_wage
      t.integer :max_wage
      t.date :deadline
      t.string :location

      t.timestamps
    end
  end
end
