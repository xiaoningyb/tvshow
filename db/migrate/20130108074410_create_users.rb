class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name, :null => false 
      t.string :password, :null => false
      t.string :email, :null => false
      t.string :backup_email
      t.string :id_card
      t.integer :age
      t.string :telephone
      t.text :address
      t.binary :image
      t.string :weibo
      t.integer :qq
      t.integer :msg_count, :null => false 
      t.integer :discuss_count, :null => false 
      t.integer :followee_count, :null => false 
      t.integer :follower_count, :null => false 
      t.integer :version, :null => false 

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
