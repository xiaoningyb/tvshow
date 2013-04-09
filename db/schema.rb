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

ActiveRecord::Schema.define(:version => 20130307083554) do

  create_table "crawler_infos", :force => true do |t|
    t.datetime "begin_time"
    t.datetime "end_time"
    t.integer  "group_counter",         :default => 0
    t.integer  "new_group_counter",     :default => 0
    t.integer  "station_counter",       :default => 0
    t.integer  "new_station_counter",   :default => 0
    t.integer  "program_counter",       :default => 0
    t.integer  "new_program_counter",   :default => 0
    t.integer  "crawl_page_counter",    :default => 0
    t.integer  "crawl_link_counter",    :default => 0
    t.integer  "crawl_station_counter", :default => 0
    t.integer  "crawl_failed_counter",  :default => 0
    t.string   "current_crawl_station"
    t.string   "current_crawl_program"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "discuss_comments", :force => true do |t|
    t.integer  "discuss_id"
    t.integer  "user_id"
    t.integer  "comment_type"
    t.text     "content"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "discuss_programships", :force => true do |t|
    t.integer  "discuss_id",     :null => false
    t.integer  "tv_group_id"
    t.integer  "tv_station_id"
    t.integer  "tv_programs_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "discuss_programships", ["discuss_id"], :name => "index_discuss_programships_on_discuss_id"
  add_index "discuss_programships", ["tv_programs_id"], :name => "index_discuss_programships_on_tv_programs_id"

  create_table "discuss_relationships", :force => true do |t|
    t.integer  "src_id",                    :null => false
    t.integer  "quote_id",                  :null => false
    t.integer  "type",       :default => 0
    t.time     "time",                      :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "discuss_relationships", ["quote_id"], :name => "index_discuss_relationships_on_quote_id"
  add_index "discuss_relationships", ["src_id"], :name => "index_discuss_relationships_on_src_id"

  create_table "discusses", :force => true do |t|
    t.string   "topic",                        :null => false
    t.integer  "user_id",                      :null => false
    t.integer  "discuss_type",  :default => 0
    t.text     "content",                      :null => false
    t.datetime "time",                         :null => false
    t.string   "location"
    t.binary   "image"
    t.integer  "tv_program_id"
    t.integer  "like",          :default => 0
    t.integer  "dislike",       :default => 0
    t.integer  "neutrality",    :default => 0
    t.integer  "src_id"
    t.integer  "quote_count",   :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "discusses", ["tv_program_id"], :name => "index_discusses_on_tv_program_id"
  add_index "discusses", ["user_id"], :name => "index_discusses_on_user_id"

  create_table "tv_groups", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "en_name",     :null => false
    t.text     "description"
    t.binary   "image"
    t.string   "image_url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tv_groupships", :force => true do |t|
    t.integer  "tv_group_id",   :null => false
    t.integer  "tv_station_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "tv_groupships", ["tv_group_id"], :name => "index_tv_groupships_on_tv_group_id"
  add_index "tv_groupships", ["tv_station_id"], :name => "index_tv_groupships_on_tv_station_id"

  create_table "tv_programs", :force => true do |t|
    t.string   "name",                         :null => false
    t.text     "description"
    t.binary   "image"
    t.string   "key_word"
    t.integer  "episode"
    t.integer  "watch_count",   :default => 0
    t.integer  "discuss_count", :default => 0
    t.integer  "checkin_count", :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "tv_programships", :force => true do |t|
    t.integer  "tv_station_id", :null => false
    t.integer  "tv_program_id", :null => false
    t.datetime "begin_time",    :null => false
    t.datetime "end_time",      :null => false
    t.integer  "episode"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "tv_programships", ["tv_program_id"], :name => "index_tv_programships_on_tv_program_id"
  add_index "tv_programships", ["tv_station_id"], :name => "index_tv_programships_on_tv_station_id"

  create_table "tv_stations", :force => true do |t|
    t.string   "name",         :null => false
    t.string   "en_name",      :null => false
    t.text     "description"
    t.binary   "image"
    t.string   "image_url"
    t.binary   "banner"
    t.string   "banner_url"
    t.date     "updated_date"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "user_checkinships", :force => true do |t|
    t.integer  "tv_program_id"
    t.integer  "user_id"
    t.datetime "time"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "user_programships", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "tv_program_id", :null => false
    t.integer  "type",          :null => false
    t.datetime "time",          :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "user_programships", ["tv_program_id"], :name => "index_user_programships_on_tv_program_id"
  add_index "user_programships", ["user_id"], :name => "index_user_programships_on_user_id"

  create_table "user_relationships", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "follower_id", :null => false
    t.integer  "type",        :null => false
    t.time     "time",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_relationships", ["follower_id"], :name => "index_user_relationships_on_follower_id"
  add_index "user_relationships", ["user_id"], :name => "index_user_relationships_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name",                                   :null => false
    t.string   "id_card"
    t.integer  "age"
    t.string   "telephone"
    t.text     "address"
    t.binary   "image"
    t.string   "weibo"
    t.integer  "qq"
    t.integer  "msg_count",              :default => 0,  :null => false
    t.integer  "discuss_count",          :default => 0,  :null => false
    t.integer  "watch_count",            :default => 0,  :null => false
    t.integer  "checkin_count",          :default => 0,  :null => false
    t.integer  "followee_count",         :default => 0,  :null => false
    t.integer  "follower_count",         :default => 0,  :null => false
    t.integer  "version",                :default => 0,  :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
