class CreateTvStations < ActiveRecord::Migration
  def self.up
    create_table :tv_stations do |t|
      t.column :name,         :string, :null => false
      t.column :en_name,      :string, :null => false
      t.column :description,  :text
      t.column :image,        :binary
      t.column :image_url,    :string
      t.column :banner,       :binary
      t.column :banner_url,   :string

      t.timestamps
    end
  end

  def self.down
    drop_table :tv_stations
  end
end
