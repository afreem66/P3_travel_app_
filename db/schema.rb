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

ActiveRecord::Schema.define(version: 20151112153700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer  "trip_id"
    t.string   "entry",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "commenter",  null: false
  end

  add_index "comments", ["trip_id"], name: "index_comments_on_trip_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["trip_id"], name: "index_taggings_on_trip_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                              null: false
    t.string   "destination",                        null: false
    t.string   "description",                        null: false
    t.string   "trip_type"
    t.string   "notes"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.date     "start_date",  default: '2015-11-06', null: false
    t.date     "end_date",    default: '2015-11-06', null: false
    t.string   "location_id"
    t.string   "latitude"
    t.string   "longitude"
  end

  add_index "trips", ["trip_type"], name: "index_trips_on_trip_type", using: :btree
  add_index "trips", ["user_id"], name: "index_trips_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.string   "username",        null: false
    t.string   "full_name",       null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "user_marker"
  end

  add_index "users", ["username"], name: "index_users_on_username", using: :btree

  add_foreign_key "comments", "trips"
  add_foreign_key "taggings", "tags"
  add_foreign_key "taggings", "trips"
  add_foreign_key "trips", "users"
end
