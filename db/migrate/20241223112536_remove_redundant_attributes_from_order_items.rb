class RemoveRedundantAttributesFromOrderItems < ActiveRecord::Migration[6.0]
  def change
    remove_column :order_items, :title, :string
    remove_column :order_items, :image_url, :string
    remove_column :order_items, :price, :decimal
    remove_column :order_items, :sku, :string
  end
end