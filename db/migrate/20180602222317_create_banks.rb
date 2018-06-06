class CreateBanks < ActiveRecord::Migration[5.1]
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.string :website_address
      t.integer :total_deposits
      t.integer :fdic_number
      t.boolean :fdic_active

      t.timestamps
    end
  end
end
