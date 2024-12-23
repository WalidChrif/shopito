class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.integer :totalItems
      t.decimal :totalPrice
      t.string :shippingAddress
      t.references :orderItems, null: false, foreign_key: true

      t.timestamps
    end
  end
end
