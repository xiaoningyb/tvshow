class CreateProgramGroups < ActiveRecord::Migration
  def change
    create_table :program_groups do |t|
      t.string   :name,           :null => false
      t.integer  :program_type,   :default => 1
      t.text     :description
      t.binary   :image
      t.string   :key_word
      t.integer  :group_type
      t.time     :interval
      t.integer  :total_episode
      t.integer  :watch_count,    :default => 0
      t.integer  :discuss_count,  :default => 0
      t.integer  :checkin_count,  :default => 0

      t.timestamps
    end
  end
end
