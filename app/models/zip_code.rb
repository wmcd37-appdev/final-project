# == Schema Information
#
# Table name: zip_codes
#
#  id          :integer          not null, primary key
#  zip_number  :integer
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ZipCode < ApplicationRecord
    belongs_to :location
    
    validates :zip_number, presence: true
    validates :location_id, presence: true
    
    
end