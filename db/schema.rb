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

ActiveRecord::Schema[7.1].define(version: 2024_04_19_030813) do
  create_table "buffet_admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "buffet_admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_admin_id"], name: "index_buffets_on_buffet_admin_id"
  end

  add_foreign_key "buffets", "buffet_admins"
end
