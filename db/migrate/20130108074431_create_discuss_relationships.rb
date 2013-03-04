class CreateDiscussRelationships < ActiveRecord::Migration

  def self.up
    create_table :discuss_relationships do |t|
      t.integer :src_id,        :null => false 
      t.integer :quote_id,      :null => false

      t.integer :type,          :default => 0 
      t.time :time,             :null => false 

      t.timestamps
    end


    add_index :discuss_relationships, :src_id, :unique => true
    add_index :discuss_relationships, :quote_id, :unique => true

  end

  def self.down
    drop_table :discuss_relationships
  end 

end
