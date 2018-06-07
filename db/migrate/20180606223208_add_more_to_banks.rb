class AddMoreToBanks < ActiveRecord::Migration[5.1]
  def change
    add_column :banks, :date_established, :string
    add_column :banks, :total_assets, :integer
  end
end

