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

ActiveRecord::Schema.define(version: 20160311225947) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "parent_id"
    t.string   "parent_type"
    t.boolean  "active",      default: true
  end

  add_index "comments", ["parent_type", "parent_id"], name: "index_comments_on_parent_type_and_parent_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "moderators", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subboard_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "moderators", ["subboard_id"], name: "index_moderators_on_subboard_id"
  add_index "moderators", ["user_id"], name: "index_moderators_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.text     "title"
    t.text     "link"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "subboard_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active",      default: true
  end

  add_index "posts", ["subboard_id"], name: "index_posts_on_subboard_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "subboards", force: :cascade do |t|
    t.string   "name"
    t.boolean  "private"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subboards", ["user_id"], name: "index_subboards_on_user_id"

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subboard_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subscriptions", ["subboard_id"], name: "index_subscriptions_on_subboard_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "temperatures", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "post_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "temptype"
  end

  add_index "temperatures", ["post_type", "post_id"], name: "index_temperatures_on_post_type_and_post_id"
  add_index "temperatures", ["user_id"], name: "index_temperatures_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "email",                  default: "", null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
