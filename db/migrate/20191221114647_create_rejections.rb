class CreateRejections < ActiveRecord::Migration[6.0]
  def change
    create_table :rejections do |t|
      t.text :feedback
      t.references :inscription, null: false, foreign_key: true

      t.timestamps
    end
  end
end
