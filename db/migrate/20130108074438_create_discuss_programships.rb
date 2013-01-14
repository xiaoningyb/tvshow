class CreateDiscussProgramships < ActiveRecord::Migration
  def change
    create_table :discuss_programships do |t|
      t.integer :discuss_id, :null => false 
      t.integer :tv_group_id
      t.integer :tv_station_id
      t.integer :tv_programs_id

      t.timestamps
    end
  end
end
