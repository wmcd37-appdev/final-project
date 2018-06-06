class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :location_address
      t.integer :user_id

      t.timestamps
    end
  end
end
