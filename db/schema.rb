# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150810142446) do

  create_table "addresses", force: :cascade do |t|
    t.string   "address",    limit: 255
    t.string   "zip",        limit: 255
    t.string   "city",       limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "country_id", limit: 4
  end

  create_table "authors", force: :cascade do |t|
    t.string   "firstname",  limit: 255
    t.string   "lastname",   limit: 255
    t.text     "biography",  limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "authors_books", force: :cascade do |t|
    t.integer "author_id", limit: 4
    t.integer "book_id",   limit: 4
  end

  add_index "authors_books", ["author_id"], name: "index_authors_books_on_author_id", using: :btree
  add_index "authors_books", ["book_id"], name: "index_authors_books_on_book_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.string   "short_descr",    limit: 255
    t.integer  "books_in_stock", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.float    "price",          limit: 24
    t.string   "picture",        limit: 255
  end

  create_table "books_categories", force: :cascade do |t|
    t.integer "category_id", limit: 4
    t.integer "book_id",     limit: 4
  end

  add_index "books_categories", ["book_id"], name: "index_books_categories_on_book_id", using: :btree
  add_index "books_categories", ["category_id"], name: "index_books_categories_on_category_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "categories", ["title"], name: "index_categories_on_title", unique: true, using: :btree

  create_table "countries", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "countries", ["name"], name: "index_countries_on_name", unique: true, using: :btree

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number",      limit: 255
    t.integer  "CVV",         limit: 4
    t.string   "month",       limit: 255
    t.integer  "year",        limit: 4
    t.string   "firstname",   limit: 255
    t.string   "lastname",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "customer_id", limit: 4
  end

  add_index "credit_cards", ["customer_id"], name: "index_credit_cards_on_customer_id", using: :btree

  create_table "customers", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "firstname",              limit: 255
    t.string   "lastname",               limit: 255
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.boolean  "admin",                  limit: 1,   default: false, null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "customers", ["email"], name: "index_customers_on_email", unique: true, using: :btree

  create_table "order_items", force: :cascade do |t|
    t.decimal  "price",                precision: 11, scale: 2
    t.integer  "quantity",   limit: 4
    t.integer  "order_id",   limit: 4
    t.integer  "book_id",    limit: 4
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "order_items", ["book_id"], name: "index_order_items_on_book_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.decimal  "total_price",                     precision: 11, scale: 2
    t.string   "state",               limit: 255
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "billing_address_id",  limit: 4
    t.integer  "shipping_address_id", limit: 4
    t.date     "completed_date"
    t.integer  "customer_id",         limit: 4
    t.integer  "credit_card_id",      limit: 4
    t.string   "delivery_type",       limit: 255
  end

  add_index "orders", ["billing_address_id"], name: "index_orders_on_billing_address_id", using: :btree
  add_index "orders", ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["delivery_type"], name: "index_orders_on_delivery_type", using: :btree
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "rating",      limit: 4
    t.text     "review",      limit: 65535
    t.integer  "item_id",     limit: 4
    t.string   "item_type",   limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "customer_id", limit: 4
    t.boolean  "approved",    limit: 1,     default: false
  end

  add_index "ratings", ["customer_id"], name: "index_ratings_on_customer_id", using: :btree
  add_index "ratings", ["item_type", "item_id"], name: "index_ratings_on_item_type_and_item_id", using: :btree

  create_table "social_accounts", force: :cascade do |t|
    t.integer  "customer_id", limit: 4
    t.string   "social",      limit: 255
    t.integer  "social_id",   limit: 8
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "social_accounts", ["customer_id"], name: "index_social_accounts_on_customer_id", using: :btree
  add_index "social_accounts", ["social"], name: "index_social_accounts_on_social", using: :btree
  add_index "social_accounts", ["social_id"], name: "index_social_accounts_on_social_id", using: :btree

  add_foreign_key "authors_books", "authors"
  add_foreign_key "authors_books", "books"
  add_foreign_key "books_categories", "books"
  add_foreign_key "books_categories", "categories"
  add_foreign_key "credit_cards", "customers"
  add_foreign_key "order_items", "books"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "credit_cards"
  add_foreign_key "orders", "customers"
  add_foreign_key "ratings", "customers"
  add_foreign_key "social_accounts", "customers"
end
