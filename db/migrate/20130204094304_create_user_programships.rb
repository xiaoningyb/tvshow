class CreateUserProgramships < ActiveRecord::Migration

  def self.up
    create_table :user_programships do |t|
      t.integer :user_id,     :null => false 
      t.integer :tv_program_id,  :null => false 
      t.integer :type,        :null => false 
      t.time :time,           :null => false 

      t.timestamps
    end
  end

 def self.down
    drop_table :user_programships
  end
end
