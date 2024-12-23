# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_23_140618) do
  create_table "customers", force: :cascade do |t|
    t.string "firstName"
    t.string "lastName"
    t.string "email"
    t.integer "orders_id", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orders_id"], name: "index_customers_on_orders_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.string "title"
    t.decimal "discount"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "totalItems"
    t.decimal "totalPrice"
    t.string "shippingAddress"
    t.integer "orderItems_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["orderItems_id"], name: "index_orders_on_orderItems_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.decimal "price"
    t.integer "stock"
    t.integer "sales_count"
    t.decimal "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "image_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
  end

  add_foreign_key "customers", "orders", column: "orders_id"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "orderItems", column: "orderItems_id"
end
