class CreateTvProgramships < ActiveRecord::Migration
  def change
    create_table :tv_programships do |t|
      t.integer :tv_station_id
      t.integer :tv_program_id
      t.time :begin
      t.time :end
      t.integer :duration
      t.boolean :is_alive

      t.timestamps
    end
  end
end
