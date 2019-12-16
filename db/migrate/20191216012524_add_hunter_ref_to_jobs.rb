class AddHunterRefToJobs < ActiveRecord::Migration[6.0]
  def change
    add_reference :jobs, :hunter, foreign_key: true
  end
end
