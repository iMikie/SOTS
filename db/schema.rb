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

ActiveRecord::Schema.define(version: 20151021035805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "performance_songs", force: :cascade do |t|
    t.integer  "performance_id"
    t.integer  "song_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performances", force: :cascade do |t|
    t.string   "title",            limit: 50
    t.date     "date"
    t.time     "performance_time"
    t.time     "call_time"
    t.string   "location"
    t.string   "event_leader"
    t.string   "leader_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "songs", force: :cascade do |t|
    t.integer  "song_number"
    t.string   "title",        limit: 64
    t.string   "composer",     limit: 64
    t.string   "larger_work",  limit: 64
    t.string   "arranger_one", limit: 64
    t.string   "arranger_two", limit: 64
    t.string   "voicing",      limit: 64
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",        limit: 50
    t.string   "email",           limit: 50
    t.string   "password_digest"
    t.string   "phone_number",    limit: 24
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name"
    t.string   "voice"
    t.string   "remember_digest"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean  "admin"
  end

end
