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

ActiveRecord::Schema.define(version: 2019_06_29_133933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "costs", force: :cascade do |t|
    t.string "name", null: false
    t.integer "expenditure", null: false
    t.date "paid_date", null: false
    t.boolean "demand", null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "item_id"
    t.string "memo"
    t.index ["item_id"], name: "index_costs_on_item_id"
    t.index ["paid_date"], name: "index_costs_on_paid_date"
    t.index ["user_id"], name: "index_costs_on_user_id"
  end

  create_table "demands", force: :cascade do |t|
    t.integer "total_cost", null: false
    t.boolean "approved", null: false
    t.text "memo"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "received", null: false
    t.index ["user_id"], name: "index_demands_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "demand_email"
    t.datetime "demanded_at"
    t.string "demand_digest"
    t.boolean "demand_activated", default: false
    t.index ["demanded_at"], name: "index_users_on_demanded_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "costs", "items"
  add_foreign_key "costs", "users"
  add_foreign_key "demands", "users"
end
