# == Schema Information
#
# Table name: bank_branches
#
#  id                  :integer          not null, primary key
#  bank_branch_name    :string
#  bank_branch_address :string
#  bank_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  location_id         :integer
#

class BankBranch < ApplicationRecord
end
