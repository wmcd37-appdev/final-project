# == Schema Information
#
# Table name: banks
#
#  id               :integer          not null, primary key
#  bank_name        :string
#  website_address  :string
#  total_deposits   :float
#  fdic_number      :integer
#  fdic_active      :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  date_established :string
#  total_assets     :float
#

class Bank < ApplicationRecord
    
 
end
