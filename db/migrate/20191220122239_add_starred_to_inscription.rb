class AddStarredToInscription < ActiveRecord::Migration[6.0]
  def change
    add_column :inscriptions, :starred, :boolean, default: false
  end
end
