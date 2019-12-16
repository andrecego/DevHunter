class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.string :social_name
      t.date :birthdate
      t.string :qualifications
      t.text :description
      t.text :experience
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
