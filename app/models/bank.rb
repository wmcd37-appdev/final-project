# == Schema Information
#
# Table name: banks
#
#  id              :integer          not null, primary key
#  bank_name       :string
#  website_address :string
#  total_deposits  :integer
#  fdic_number     :integer
#  fdic_active     :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Bank < ApplicationRecord
end
