class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.references :orders, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
