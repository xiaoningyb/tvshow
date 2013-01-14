class CreateDiscussRelationships < ActiveRecord::Migration
  def change
    create_table :discuss_relationships do |t|
      t.integer :discuss_id, :null => false 
      t.integer :user_id, :null => false 
      t.integer :reply_id
      t.integer :reply_user_id
      t.integer :type, :null => false 
      t.time :time, :null => false 

      t.timestamps
    end
  end
end
