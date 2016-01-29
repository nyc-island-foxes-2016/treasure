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

ActiveRecord::Schema.define(version: 20160128220610) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string   "name",        limit: 50,                   null: false
    t.string   "description", limit: 1000,                 null: false
    t.boolean  "swapped",                  default: false
    t.integer  "user_id",                                  null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "items", ["user_id"], name: "index_items_on_user_id", using: :btree

  create_table "matches", force: :cascade do |t|
    t.integer  "given_swipe_id",    null: false
    t.integer  "received_swipe_id", null: false
    t.datetime "swapped_at"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "matches", ["given_swipe_id"], name: "index_matches_on_given_swipe_id", using: :btree
  add_index "matches", ["received_swipe_id"], name: "index_matches_on_received_swipe_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "match_id",   null: false
    t.integer  "user_id",    null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["match_id"], name: "index_messages_on_match_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "swipes", force: :cascade do |t|
    t.integer  "my_item_id",    null: false
    t.integer  "other_item_id", null: false
    t.string   "direction",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "swipes", ["my_item_id"], name: "index_swipes_on_my_item_id", using: :btree
  add_index "swipes", ["other_item_id"], name: "index_swipes_on_other_item_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 30, null: false
    t.string   "email",                          null: false
    t.string   "password_digest",                null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
