class CreateTvGroupships < ActiveRecord::Migration
  def self.up
    create_table :tv_groupships do |t|
      t.column :tv_group_id, :integer, :null => false
      t.column :tv_station_id, :integer, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :tv_groupships
  end
end
