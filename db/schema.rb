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

ActiveRecord::Schema.define(version: 20151105133102) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "counters", force: :cascade do |t|
    t.integer  "counter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "venue_id"
    t.string   "name"
    t.datetime "time"
    t.text     "description"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "facebook_id",        limit: 8
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name_ru"
    t.string   "name_arm"
    t.string   "description_ru"
    t.string   "description_arm"
    t.datetime "deleted_at"
  end

  add_index "events", ["deleted_at"], name: "index_events_on_deleted_at"

  create_table "favorite_events", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_venues", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gcm_ids", force: :cascade do |t|
    t.string  "gcm_id"
    t.integer "user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "message"
    t.string   "message_armenian"
    t.string   "message_russian"
    t.datetime "fire_time"
    t.integer  "event_id"
    t.boolean  "sent",             default: false
    t.integer  "venue_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name_ru"
    t.string   "name_arm"
  end

  create_table "user_user_categories", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "user_category_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "gcm_id"
    t.string   "apns_token"
    t.boolean  "logged_in"
  end

  create_table "users_notifications", force: :cascade do |t|
    t.integer "user_id"
    t.integer "notification_id"
  end

  create_table "venue_categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name_ru"
    t.string   "name_arm"
    t.integer  "position"
    t.datetime "deleted_at"
  end

  add_index "venue_categories", ["deleted_at"], name: "index_venue_categories_on_deleted_at"

  create_table "venue_photos", force: :cascade do |t|
    t.integer  "venue_id"
    t.string   "photo_url"
    t.string   "thumb_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
    t.string   "fb_page"
    t.text     "description"
    t.string   "address"
    t.string   "phone"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "venue_category_id"
    t.string   "name_ru"
    t.string   "name_arm"
    t.text     "description_ru"
    t.text     "description_arm"
    t.datetime "deleted_at"
  end

  add_index "venues", ["deleted_at"], name: "index_venues_on_deleted_at"

end
