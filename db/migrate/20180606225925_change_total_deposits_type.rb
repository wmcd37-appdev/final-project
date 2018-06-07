class ChangeTotalDepositsType < ActiveRecord::Migration[5.1]
  def change
    change_column :banks, :total_assets, :float
    change_column :banks, :total_deposits, :float
  end
end
