class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :title
      t.decimal :price
      t.integer :stock
      t.integer :sales_count
      t.decimal :discount

      t.timestamps
    end
  end
end
