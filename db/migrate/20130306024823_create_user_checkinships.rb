class CreateUserCheckinships < ActiveRecord::Migration
  def change
    create_table :user_checkinships do |t|
      t.integer :user_id
      t.datetime :time
      t.belongs_to :program, :polymorphic => true

      t.timestamps
    end
  end
end
