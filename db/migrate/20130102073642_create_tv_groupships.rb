class CreateTvGroupships < ActiveRecord::Migration
  def change
    create_table :tv_groupships do |t|
      t.integer :tv_group_id
      t.integer :tv_station_id

      t.timestamps
    end
  end
end
