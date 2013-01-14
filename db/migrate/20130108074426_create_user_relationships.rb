class CreateUserRelationships < ActiveRecord::Migration
  def change
    create_table :user_relationships do |t|
      t.integer :user_id, :null => false 
      t.integer :follow_id, :null => false 
      t.integer :type, :null => false 
      t.time :time, :null => false 

      t.timestamps
    end
  end
end
