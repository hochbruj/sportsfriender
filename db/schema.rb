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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131208110921) do

  create_table "assessment_translations", :force => true do |t|
    t.integer  "assessment_id"
    t.string   "locale"
    t.text     "cat1"
    t.text     "cat2"
    t.text     "cat3"
    t.text     "cat4"
    t.text     "cat5"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "assessment_translations", ["assessment_id"], :name => "index_assessment_translations_on_assessment_id"
  add_index "assessment_translations", ["locale"], :name => "index_assessment_translations_on_locale"

  create_table "assessments", :force => true do |t|
    t.integer  "sport_id"
    t.integer  "level"
    t.text     "cat1"
    t.text     "cat2"
    t.text     "cat3"
    t.text     "cat4"
    t.text     "cat5"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "event_posts", :force => true do |t|
    t.string   "content"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "sport_id"
    t.integer  "city_id"
    t.integer  "location_id"
    t.datetime "start_at"
    t.datetime "finish_at"
    t.string   "mode"
    t.string   "gender"
    t.text     "info"
    t.integer  "skill_from"
    t.integer  "skill_to"
    t.integer  "age_from"
    t.integer  "age_to"
    t.integer  "max_part"
    t.integer  "group_id"
    t.boolean  "private"
    t.boolean  "cancelled"
    t.text     "creason"
    t.string   "emails"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sport_id"
    t.integer  "rated_by"
    t.string   "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.integer  "sport_id"
    t.float    "lat"
    t.float    "lng"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "reference"
    t.string   "google_id"
    t.string   "timezone"
  end

  create_table "members", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "participants", :force => true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "organizer"
    t.boolean  "rated"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pointers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "cat_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "rated_by"
    t.integer  "sport_id"
    t.integer  "event_id"
    t.integer  "cat1"
    t.integer  "cat2"
    t.integer  "cat3"
    t.integer  "cat4"
    t.integer  "cat5"
    t.integer  "dif1"
    t.integer  "dif2"
    t.integer  "dif3"
    t.integer  "dif4"
    t.integer  "dif5"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sport_translations", :force => true do |t|
    t.integer  "sport_id"
    t.string   "locale"
    t.string   "name"
    t.string   "cat1"
    t.string   "cat2"
    t.string   "cat3"
    t.string   "cat4"
    t.string   "cat5"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sport_translations", ["locale"], :name => "index_sport_translations_on_locale"
  add_index "sport_translations", ["sport_id"], :name => "index_sport_translations_on_sport_id"

  create_table "sports", :force => true do |t|
    t.string   "name"
    t.string   "cat1"
    t.string   "cat2"
    t.string   "cat3"
    t.string   "cat4"
    t.string   "cat5"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "stats", :force => true do |t|
    t.integer  "user_id"
    t.integer  "sport_id"
    t.decimal  "cat1",       :precision => 3, :scale => 1
    t.decimal  "cat2",       :precision => 3, :scale => 1
    t.decimal  "cat3",       :precision => 3, :scale => 1
    t.decimal  "cat4",       :precision => 3, :scale => 1
    t.decimal  "cat5",       :precision => 3, :scale => 1
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.string   "gender"
    t.integer  "sport_id"
    t.text     "comment"
    t.date     "dob"
    t.string   "image"
    t.boolean  "admin"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "city_reference"
    t.string   "country_code"
    t.float    "lat"
    t.float    "lng"
    t.string   "city_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
