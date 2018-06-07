class AddRadiusToLocationsAgain < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :searchradius, :integer
  end
end
