class AddDisplayAddressToLocations < ActiveRecord::Migration[5.1]
  def change
    add_column :locations, :display_address, :string
  end
end
