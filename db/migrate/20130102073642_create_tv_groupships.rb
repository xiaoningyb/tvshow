class CreateTvGroupships < ActiveRecord::Migration
  def self.up
    create_table :tv_groupships do |t|
      t.column :tv_group_id, :integer, :null => false
      t.column :tv_station_id, :integer, :null => false

      t.timestamps
    end

    add_index :tv_groupships, :tv_group_id
    add_index :tv_groupships, :tv_station_id
  end

  def self.down
    drop_table :tv_groupships
  end
end
