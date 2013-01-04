class CreateTvProgramships < ActiveRecord::Migration
  def self.up
    create_table :tv_programships do |t|
      t.column :tv_station_id, :integer, :null => false
      t.column :tv_program_id, :integer, :null => false
      t.column :begin, :datetime
      t.column :end, :datetime
      t.column :duration, :integer
      t.column :is_alive, :boolean

      t.timestamps
    end
  end
  
  def self.down
    drop_table :tv_programships
  end
end
