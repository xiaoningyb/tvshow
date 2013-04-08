class CreateCrawlerInfos < ActiveRecord::Migration
  def self.up
    create_table :crawler_infos do |t|
      t.datetime :begin_time
      t.datetime :end_time
      t.integer  :group_counter,         :default => 0
      t.integer  :new_group_counter,     :default => 0
      t.integer  :station_counter,       :default => 0
      t.integer  :new_station_counter,   :default => 0
      t.integer  :program_counter,       :default => 0
      t.integer  :new_program_counter,   :default => 0
      t.integer  :crawl_page_counter,    :default => 0
      t.integer  :crawl_link_counter,    :default => 0
      t.integer  :crawl_station_counter, :default => 0
      t.integer  :crawl_failed_counter,  :default => 0
      t.string   :current_crawl_station
      t.string   :current_crawl_program

      t.timestamps
    end
  end

  def self.down
    drop_table :crawler_infos
  end
end
