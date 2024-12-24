# == Schema Information
#
# Table name: orders
#
#  id              :uuid             not null, primary key
#  customer_id     :uuid             not null
#  totalItems      :integer          default(0), not null
#  totalPrice      :decimal(, )      default(0.0), not null
#  shippingAddress :string
#  orderItems_id   :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Order < ApplicationRecord
  
  belongs_to :customer, optional: true
  has_many :orderItems, dependent: :destroy

end
