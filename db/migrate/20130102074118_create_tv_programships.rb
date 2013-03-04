class CreateTvProgramships < ActiveRecord::Migration
  def self.up
    create_table :tv_programships do |t|
      t.column :tv_station_id, :integer, :null => false
      t.column :tv_program_id, :integer, :null => false
      t.column :begin, :datetime, :null => false 
      t.column :end, :datetime, :null => false 

      t.timestamps
    end

    add_index :tv_programships, :tv_station_id
    add_index :tv_programships, :tv_program_id
  end
  
  def self.down
    drop_table :tv_programships
  end
end
