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

ActiveRecord::Schema.define(version: 20160303190254) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "temperature"
    t.integer  "parent_id"
    t.string   "parent_type"
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
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "temperature"
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

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
