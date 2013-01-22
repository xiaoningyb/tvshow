class CreateDiscusses < ActiveRecord::Migration
  def self.up
    create_table :discusses do |t|
      t.string :topic,         :null => false
      t.integer :user_id,      :null => false
      t.integer :discuss_type, :default => 0
      t.text :content,         :null => false
      t.time :time,            :null => false 
      t.string :location
      t.binary :image
      t.column :tv_program_id, :integer

      t.column "like",         :integer,   :default => 0
      t.column "dislike",      :integer,   :default => 0
      t.column "neutrality",   :integer,   :default => 0 
      t.column "src_id",       :integer
      t.column "quote_count",  :integer,   :default => 0      

      t.timestamps
    end
  end

  def self.down
    drop_table :discusses
  end 

end
