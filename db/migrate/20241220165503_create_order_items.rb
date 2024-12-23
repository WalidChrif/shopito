class CreateOrderItems < ActiveRecord::Migration[8.0]
  def change
    create_table :order_items do |t|
      t.string :title
      t.integer :quantity
      t.string :imageUrl
      t.decimal :price
      t.string :sku
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
