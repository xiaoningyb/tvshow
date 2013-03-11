class CreateUserProgramships < ActiveRecord::Migration

  def self.up
    create_table :user_programships do |t|
      t.integer :user_id,        :null => false 
      t.integer :tv_program_id,  :null => false 
      t.integer :type,           :null => false 
      t.datetime :time,          :null => false 

      t.timestamps
    end

    add_index :user_programships, :user_id
    add_index :user_programships, :tv_program_id

  end

 def self.down
    drop_table :user_programships
  end
end
