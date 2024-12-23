class AddPriceAndTitleAndDiscountToOrderItems < ActiveRecord::Migration[8.0]
  def change
    add_column :order_items, :price, :decimal
    add_column :order_items, :title, :string
    add_column :order_items, :discount, :decimal
  end
end
