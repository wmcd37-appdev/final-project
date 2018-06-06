class AddZipLocationToLocation < ActiveRecord::Migration[5.1]
  def change
        add_column :locations, :ziplocation, :integer
  end
end
