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

ActiveRecord::Schema.define(version: 2018_04_27_191059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.datetime "starting_at"
    t.datetime "ending_at"
    t.float "distance_travelled"
    t.bigint "company_id"
    t.bigint "user_id"
    t.bigint "vehicle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["company_id"], name: "index_trips_on_company_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "role"
    t.bigint "company_id"
    t.text "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "authentication_token", limit: 30
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "registration_number"
    t.integer "type"
    t.text "description"
    t.bigint "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_vehicles_on_company_id"
  end

  add_foreign_key "trips", "companies"
  add_foreign_key "trips", "users"
  add_foreign_key "trips", "vehicles"
  add_foreign_key "users", "companies"
  add_foreign_key "vehicles", "companies"
end
