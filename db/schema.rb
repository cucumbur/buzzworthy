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

ActiveRecord::Schema.define(version: 20151120115416) do

  create_table "dun_events", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "effect"
  end

  create_table "dungeons", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "read",       default: false
  end

  add_index "messages", ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "newsposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.text     "bio"
    t.integer  "level",             default: 1
    t.integer  "buzz",              default: 0
    t.integer  "max_motivation",    default: 100
    t.integer  "cur_motivation",    default: 100
    t.integer  "max_dignity",       default: 20
    t.integer  "cur_dignity",       default: 20
    t.integer  "max_strangepoints", default: 10
    t.integer  "cur_strangepoints", default: 10
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.integer  "gender"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.integer  "money",             default: 0
    t.integer  "verve",             default: 2
    t.integer  "heart",             default: 2
    t.integer  "allure",            default: 2
    t.integer  "strangeness",       default: 2
    t.integer  "serendipity",       default: 2
    t.integer  "upgrade_points",    default: 0
    t.integer  "genre"
  end

end
