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
#

class Location < ApplicationRecord
end
