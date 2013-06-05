class CreateTvPrograms < ActiveRecord::Migration
  def self.up
    create_table :tv_programs do |t|
      t.column :name,             :string,  :null => false
      t.column :program_type,     :integer, :default => 0
      t.column :description,      :text
      t.column :image,            :binary
      t.column :key_word,         :string
      t.column :episode,          :integer
      t.column :group_type,       :integer, :default => 0
      t.column :program_group_id, :integer
      t.column :watch_count,      :integer, :default => 0
      t.column :discuss_count,    :integer, :default => 0
      t.column :checkin_count,    :integer, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :tv_programs
  end
end
