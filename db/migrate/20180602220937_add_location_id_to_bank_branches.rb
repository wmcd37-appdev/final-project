class AddLocationIdToBankBranches < ActiveRecord::Migration[5.1]
  def change
    add_column :bank_branches, :location_id, :integer
  end
end
