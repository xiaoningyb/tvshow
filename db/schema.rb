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

ActiveRecord::Schema.define(:version => 20130108074438) do

  create_table "discuss_programships", :force => true do |t|
    t.integer  "discuss_id",     :null => false
    t.integer  "tv_group_id"
    t.integer  "tv_station_id"
    t.integer  "tv_programs_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "discuss_relationships", :force => true do |t|
    t.integer  "src_id",                    :null => false
    t.integer  "quote_id",                  :null => false
    t.integer  "type",       :default => 0
    t.time     "time",                      :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "discusses", :force => true do |t|
    t.string   "topic",                        :null => false
    t.integer  "user_id",                      :null => false
    t.integer  "discuss_type",  :default => 0
    t.text     "content",                      :null => false
    t.time     "time",                         :null => false
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

  create_table "tv_groups", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.binary   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tv_groupships", :force => true do |t|
    t.integer  "tv_group_id",   :null => false
    t.integer  "tv_station_id", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tv_programs", :force => true do |t|
    t.string   "name",                            :null => false
    t.text     "description"
    t.binary   "image"
    t.string   "key_word"
    t.integer  "episode"
    t.integer  "subscriber_count", :default => 0
    t.integer  "discuss_count",    :default => 0
    t.integer  "checkin_count",    :default => 0
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "tv_programships", :force => true do |t|
    t.integer  "tv_station_id", :null => false
    t.integer  "tv_program_id", :null => false
    t.datetime "begin",         :null => false
    t.datetime "end",           :null => false
    t.integer  "duration",      :null => false
    t.boolean  "is_alive",      :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "tv_stations", :force => true do |t|
    t.string   "name",        :null => false
    t.text     "description"
    t.binary   "image"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "user_relationships", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.integer  "follower_id", :null => false
    t.integer  "type",        :null => false
    t.time     "time",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "password",                      :null => false
    t.string   "email",                         :null => false
    t.string   "backup_email"
    t.string   "id_card"
    t.integer  "age"
    t.string   "telephone"
    t.text     "address"
    t.binary   "image"
    t.string   "weibo"
    t.integer  "qq"
    t.integer  "msg_count",      :default => 0, :null => false
    t.integer  "discuss_count",  :default => 0, :null => false
    t.integer  "followee_count", :default => 0, :null => false
    t.integer  "follower_count", :default => 0, :null => false
    t.integer  "version",        :default => 0, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

end
