class RemoveRedundantAttributesFromOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :title, :string
    remove_column :order_items, :imageUrl, :string
    remove_column :order_items, :price, :decimal
    remove_column :order_items, :sku, :string
  end
end