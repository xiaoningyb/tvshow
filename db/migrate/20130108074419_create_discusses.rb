class CreateDiscusses < ActiveRecord::Migration
  def self.up
    create_table :discusses do |t|
      t.string :topic,         :null => false
      t.integer :user_id,      :null => false
      t.integer :discuss_type, :default => 0
      t.text :content,         :null => false
      t.datetime :time,        :null => false 
      t.string :location
      t.binary :image
      t.belongs_to :program,   :polymorphic => true

      t.integer :like,         :default => 0
      t.integer :dislike,      :default => 0
      t.integer :neutrality,   :default => 0 
      t.integer :src_id
      t.integer :quote_count,  :default => 0

      t.timestamps
    end

    add_index :discusses, :user_id
    add_index :discusses, :program_id
  end

  def self.down
    drop_table :discusses
  end 

end
