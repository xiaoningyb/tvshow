class CreateUserProgramships < ActiveRecord::Migration

  def self.up
    create_table :user_programships do |t|
      t.integer :user_id,        :null => false 
      t.datetime :time,          :null => false 
      t.belongs_to :program,     :polymorphic => true

      t.timestamps
    end

    add_index :user_programships, :user_id
    add_index :user_programships, :program_id

  end

 def self.down
    drop_table :user_programships
  end
end
