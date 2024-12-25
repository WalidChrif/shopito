class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :total_items
      t.decimal :total_price
      t.string :shipping_address
      t.references :order_items, null: false, foreign_key: true

      t.timestamps
    end
  end
end
