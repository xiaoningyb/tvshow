class CreateCrawlerInfos < ActiveRecord::Migration
  def self.up
    create_table :crawler_infos do |t|
      t.datetime :begin
      t.datetime :end
      t.integer :group_counter
      t.integer :new_group_counter
      t.integer :station_counter
      t.integer :new_station_counter
      t.integer :program_counter
      t.integer :new_program_counter
      t.integer :crawl_page_counter
      t.integer :crawl_link_counter

      t.timestamps
    end
  end

  def self.down
    drop_table :crawler_infos
  end
end
