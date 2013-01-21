class CreateTvPrograms < ActiveRecord::Migration
  def self.up
    create_table :tv_programs do |t|
      t.column :name,             :string,  :null => false
      t.column :description,      :text
      t.column :image,            :binary
      t.column :key_word,         :string
      t.column :episode,          :integer
      t.column :subscriber_count, :integer, :default => 0, :null => false
      t.column :discuss_count,    :integer, :default => 0, :null => false
      t.column :checkin_count,    :integer, :default => 0, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tv_programs
  end
end
