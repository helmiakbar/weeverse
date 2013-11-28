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

ActiveRecord::Schema.define(version: 20131128081657) do

  create_table "events", force: true do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.string "country"
    t.string "city"
    t.string "postal_code"
    t.string "creator"
    t.float  "lat"
    t.float  "long"
    t.date   "date"
  end

  create_table "ideas", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "city"
    t.string   "postal_code"
    t.string   "creator"
    t.string   "region_name"
    t.integer  "project_id"
    t.integer  "event_id"
    t.float    "lat"
    t.float    "long"
  end

  create_table "media_urls", force: true do |t|
    t.string   "url"
    t.integer  "social_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.integer  "social_id"
    t.boolean  "default"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "country"
    t.string   "city"
    t.string   "postal_code"
    t.string   "image"
    t.string   "creator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "region_name"
    t.integer  "parent_id"
    t.float    "lat"
    t.float    "long"
  end

  create_table "projects_users", id: false, force: true do |t|
    t.integer "project_id"
    t.integer "user_id"
  end

  create_table "rails_admin_histories", force: true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      limit: 2
    t.integer  "year",       limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], name: "index_rails_admin_histories", using: :btree

  create_table "socials", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.string   "country"
    t.string   "city"
    t.string   "postal_code"
    t.string   "creator"
    t.integer  "project_id"
    t.float    "lat"
    t.float    "long"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "project_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["idea_id"], name: "index_taggings_on_idea_id", using: :btree
  add_index "taggings", ["project_id"], name: "index_taggings_on_project_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
