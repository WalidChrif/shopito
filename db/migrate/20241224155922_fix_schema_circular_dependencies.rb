class FixSchemaCircularDependencies < ActiveRecord::Migration[8.0]
  def change
    # Drop existing foreign keys
    remove_foreign_key :customers, :orders
    remove_foreign_key :orders, :order_items
    
    # Remove problematic columns
    remove_column :customers, :orders_id
    remove_column :orders, :order_items_id
    
    # Ensure proper foreign keys exist
    unless foreign_key_exists?(:orders, :customers)
      add_foreign_key :orders, :customers
    end
    
    unless foreign_key_exists?(:order_items, :orders)
      add_foreign_key :order_items, :orders
    end
  end
end