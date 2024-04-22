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

ActiveRecord::Schema[7.1].define(version: 2024_04_22_043546) do
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
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.string "description"
    t.string "payment_methods"
    t.integer "buffet_admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_admin_id"], name: "index_buffets_on_buffet_admin_id"
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
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
  end

  add_foreign_key "buffet_admins", "buffets"
  add_foreign_key "buffets", "buffet_admins"
  add_foreign_key "event_details", "event_options"
  add_foreign_key "event_details", "event_types"
  add_foreign_key "event_types", "buffets"
end
