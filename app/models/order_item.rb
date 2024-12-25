# == Schema Information
#
# Table name: order_items
#
#  id         :uuid             not null, primary key
#  order_id   :uuid             not null
#  quantity   :integer          default(1), not null
#  price      :decimal(, )
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_order_items_on_order_id    (order_id)
#  index_order_items_on_product_id  (product_id)
#
class OrderItem < ApplicationRecord
  belongs_to :order
end

