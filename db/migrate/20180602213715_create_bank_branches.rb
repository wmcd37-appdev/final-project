class CreateBankBranches < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_branches do |t|
      t.string :bank_branch_name
      t.string :bank_branch_address
      t.integer :bank_id

      t.timestamps
    end
  end
end
