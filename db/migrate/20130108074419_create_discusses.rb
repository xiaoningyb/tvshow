class CreateDiscusses < ActiveRecord::Migration
  def self.up
    create_table :discusses do |t|
      t.string :topic,         :null => false
      t.integer :host,         :null => false
      t.integer :type,         :null => false
      t.text :content,         :null => false
      t.time :time,            :null => false 
      t.string :location
      t.binary :image

      t.column "like",         :integer,   :default => 0
      t.column "dislike",      :integer,   :default => 0
      t.column "neutrality",   :integer,   :default => 0 
      t.column "quoted_id",    :integer
      t.column "quoted_count", :integer,   :default => 0        

      t.timestamps
    end
  end

  def self.down
    drop_table :discusses
  end 

end
