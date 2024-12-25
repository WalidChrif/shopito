# == Schema Information
#
# Table name: orders
#
#  id              :uuid             not null, primary key
#  customer_id     :uuid             not null
#  total_items      :integer          default(0), not null
#  total_price      :decimal(, )      default(0.0), not null
#  shipping_address :string
#  orderItems_id   :uuid             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Order < ApplicationRecord
  
  belongs_to :customer, optional: true
  has_many :order_items, dependent: :destroy

  after_initialize :set_pending_status

  private
  def set_pending_status
    self.status = "pending" if self.status.nil?
  end
  

end
