class CreateUserCheckinships < ActiveRecord::Migration
  def change
    create_table :user_checkinships do |t|
      t.integer :tv_program_id
      t.integer :user_id
      t.datetime :time

      t.timestamps
    end
  end
end
