class CreateZipCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :zip_codes do |t|
      t.integer :zip_number
      t.integer :location_id

      t.timestamps
    end
  end
end
