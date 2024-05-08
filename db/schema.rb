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

ActiveRecord::Schema[7.1].define(version: 2024_05_08_183901) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "buffet_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.integer "buffet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_buffet_admins_on_buffet_id"
    t.index ["email"], name: "index_buffet_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_buffet_admins_on_reset_password_token", unique: true
  end

  create_table "buffets", force: :cascade do |t|
    t.string "brand_name"
    t.string "company_name"
    t.string "registration_number"
    t.string "phone_number"
    t.string "email"
    t.string "full_address"
    t.string "address"
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.string "description"
    t.integer "buffet_admin_id", null: false
    t.integer "payment_methods_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_admin_id"], name: "index_buffets_on_buffet_admin_id"
    t.index ["payment_methods_id"], name: "index_buffets_on_payment_methods_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "social_security_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "event_details", force: :cascade do |t|
    t.integer "event_option_id", null: false
    t.integer "event_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_option_id"], name: "index_event_details_on_event_option_id"
    t.index ["event_type_id"], name: "index_event_details_on_event_type_id"
  end

  create_table "event_options", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_prices", force: :cascade do |t|
    t.decimal "min_price"
    t.decimal "extra_guest_fee"
    t.decimal "overtime_fee"
    t.boolean "weekend_schedule"
    t.integer "event_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_type_id"], name: "index_event_prices_on_event_type_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "menu"
    t.boolean "location"
    t.integer "min_guests"
    t.integer "max_guests"
    t.integer "duration"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_price_id"
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
    t.index ["event_price_id"], name: "index_event_types_on_event_price_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.decimal "base_price"
    t.decimal "discount"
    t.decimal "increase"
    t.string "description"
    t.date "expiration_date"
    t.integer "order_id", null: false
    t.decimal "final_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_invoices_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "buffet_id", null: false
    t.integer "event_type_id", null: false
    t.date "event_date"
    t.integer "guests"
    t.string "address"
    t.string "more_details"
    t.string "code"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_orders_on_buffet_id"
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["event_type_id"], name: "index_orders_on_event_type_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "name"
    t.string "details"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_payment_methods_on_buffet_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "buffet_admins", "buffets"
  add_foreign_key "buffets", "buffet_admins"
  add_foreign_key "buffets", "payment_methods", column: "payment_methods_id"
  add_foreign_key "event_details", "event_options"
  add_foreign_key "event_details", "event_types"
  add_foreign_key "event_prices", "event_types"
  add_foreign_key "event_types", "buffets"
  add_foreign_key "event_types", "event_prices"
  add_foreign_key "invoices", "orders"
  add_foreign_key "orders", "buffets"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "event_types"
  add_foreign_key "payment_methods", "buffets"
end
