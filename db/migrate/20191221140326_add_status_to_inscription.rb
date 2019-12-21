class AddStatusToInscription < ActiveRecord::Migration[6.0]
  def change
    add_column :inscriptions, :status, :integer, default: 0
  end
end
