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

ActiveRecord::Schema.define(version: 20151106051434) do

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.text     "bio"
    t.integer  "level"
    t.integer  "buzz"
    t.integer  "max_motivation"
    t.integer  "cur_motivation"
    t.integer  "max_dignity"
    t.integer  "cur_dignity"
    t.integer  "max_strangepoints"
    t.integer  "cur_strangepoints"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
