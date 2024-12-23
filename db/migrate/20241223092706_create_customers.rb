class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.references :orders, null: false, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
