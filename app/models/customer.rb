# == Schema Information
#
# Table name: customers
#
#  id         :uuid             not null, primary key
#  first_name  :string
#  last_name   :string
#  email      :string
#  address    :string
#  orders_id  :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Customer < ApplicationRecord
  has_many :orders
end
