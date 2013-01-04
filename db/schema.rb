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

ActiveRecord::Schema.define(:version => 20130102074118) do

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
    t.string   "name",        :null => false
    t.text     "description"
    t.binary   "image"
    t.string   "key_word"
    t.integer  "episode"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tv_programships", :force => true do |t|
    t.integer  "tv_station_id", :null => false
    t.integer  "tv_program_id", :null => false
    t.datetime "begin"
    t.datetime "end"
    t.integer  "duration"
    t.boolean  "is_alive"
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

end
