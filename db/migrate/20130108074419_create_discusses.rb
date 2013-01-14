class CreateDiscusses < ActiveRecord::Migration
  def change
    create_table :discusses do |t|
      t.string :topic, :null => false 
      t.integer :host, :null => false 
      t.integer :type, :null => false 
      t.string :content, :null => false 
      t.time :time, :null => false 
      t.binary :image
      t.integer :commit_count, :null => false 

      t.timestamps
    end
  end
end
