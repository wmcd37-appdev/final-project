# == Schema Information
#
# Table name: locations
#
#  id               :integer          not null, primary key
#  location_name    :string
#  location_address :string
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  latitude         :float
#  longitude        :float
#  ziplocation      :integer
#  display_address  :string
#  searchradius     :integer
#

class Location < ApplicationRecord
    validates :location_name, presence: true
    validates :location_name, uniqueness: true
    validates :location_address, presence: true
    validates :location_address, uniqueness: true
    validates :display_address, presence: true
    validates :display_address, uniqueness: true
    validates :ziplocation, numericality: { only_integer: true }
    validates :latitude, numericality: true
    validates :longitude, numericality: true
    validates :searchradius, numericality: { only_integer: true }
    validates :user_id, presence: true
    
    
    has_many :zip_codes
    has_many :bank_branches
end
