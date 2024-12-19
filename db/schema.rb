ActiveRecord::Schema[8.0].define(version: 2024_12_19_164603) do
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
    t.string "role"
  end
end
