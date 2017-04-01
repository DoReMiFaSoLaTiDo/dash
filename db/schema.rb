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

ActiveRecord::Schema.define(version: 20170401183632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doctors", force: :cascade do |t|
    t.string   "first_name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "title",      default: "Dr."
    t.string   "last_name"
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "description"
    t.integer  "doctor_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "ratings",     default: 1, null: false
    t.string   "reviewer"
  end

  add_index "reviews", ["doctor_id"], name: "index_reviews_on_doctor_id", using: :btree

  add_foreign_key "reviews", "doctors"
end
