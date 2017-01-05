# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170105042657) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "depth",       default: 0, null: false
    t.integer  "lft",                     null: false
    t.integer  "rgt",                     null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["lft"], name: "index_categories_on_lft"
    t.index ["rgt"], name: "index_categories_on_rgt"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_comments_on_product_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "component_details", force: :cascade do |t|
    t.integer  "component_id"
    t.integer  "product_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["component_id"], name: "index_component_details_on_component_id"
    t.index ["product_id"], name: "index_component_details_on_product_id"
  end

  create_table "components", force: :cascade do |t|
    t.string   "name"
    t.integer  "quantity"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "discount_code"
    t.string   "description"
    t.integer  "redemption"
    t.integer  "coupon_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_favorites_on_product_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "order_details", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_code"
    t.integer  "status"
    t.float    "total_pay"
    t.string   "shipping_address"
    t.integer  "user_id"
    t.integer  "coupon_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["coupon_id"], name: "index_orders_on_coupon_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "product_code"
    t.string   "name"
    t.string   "image"
    t.float    "price"
    t.integer  "in_stock"
    t.text     "description"
    t.float    "avarage_rating"
    t.integer  "category_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rate"
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_rates_on_product_id"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "suggests", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["category_id"], name: "index_suggests_on_category_id"
    t.index ["user_id"], name: "index_suggests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "avatar"
    t.boolean  "is_admin"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
