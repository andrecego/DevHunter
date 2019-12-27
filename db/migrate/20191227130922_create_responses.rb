class CreateResponses < ActiveRecord::Migration[6.0]
  def change
    create_table :responses do |t|
      t.text :comment
      t.integer :status, default: 0
      t.references :approval, null: false, foreign_key: true

      t.timestamps
    end
  end
end
