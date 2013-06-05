class CreateUserCheckinships < ActiveRecord::Migration
  def self.up
    create_table :user_checkinships do |t|
      t.integer :user_id
      t.datetime :time
      t.belongs_to :program, :polymorphic => true

      t.timestamps
    end

    add_index :user_checkinships, :user_id
    add_index :user_checkinships, :program_id
  end

 def self.down
    drop_table :user_programships
  end
end
