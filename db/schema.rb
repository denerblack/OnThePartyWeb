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

ActiveRecord::Schema.define(:version => 20120614193813) do

  create_table "categories", :force => true do |t|
    t.string   "id_foursquare"
    t.string   "name"
    t.string   "plural_name"
    t.string   "short_name"
    t.string   "icon_prefix"
    t.string   "icon_name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "categories_venues", :force => true do |t|
    t.integer "category_id"
    t.integer "venue_id"
  end

  create_table "event_comments", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_comments", ["event_id"], :name => "index_event_comments_on_event_id"
  add_index "event_comments", ["user_id"], :name => "index_event_comments_on_user_id"

  create_table "event_photo_comments", :force => true do |t|
    t.integer  "event_photo_id"
    t.integer  "user_id"
    t.text     "comment"
    t.datetime "deleted_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "event_photo_comments", ["event_photo_id"], :name => "index_event_photo_comments_on_event_photo_id"
  add_index "event_photo_comments", ["user_id"], :name => "index_event_photo_comments_on_user_id"

  create_table "event_photos", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_photo_id"
    t.boolean  "is_principal"
    t.datetime "deleted_at"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "event_photos", ["event_id"], :name => "index_event_photos_on_event_id"
  add_index "event_photos", ["user_photo_id"], :name => "index_event_photos_on_user_photo_id"

  create_table "event_ratings", :force => true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_ratings", ["event_id"], :name => "index_event_ratings_on_event_id"
  add_index "event_ratings", ["user_id"], :name => "index_event_ratings_on_user_id"

  create_table "events", :force => true do |t|
    t.integer  "venue_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "occur_at"
    t.integer  "rating"
    t.datetime "deleted_at"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "events", ["user_id"], :name => "index_events_on_user_id"
  add_index "events", ["venue_id"], :name => "index_events_on_venue_id"

  create_table "user_photos", :force => true do |t|
    t.integer  "user_id"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.text     "description"
    t.datetime "deleted_at"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "user_photos", ["user_id"], :name => "index_user_photos_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "facebook"
    t.string   "twitter"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.boolean  "promoter"
    t.datetime "deleted_at"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "venues", :force => true do |t|
    t.string   "id_foursquare"
    t.string   "name"
    t.string   "contact"
    t.string   "address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "country"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
