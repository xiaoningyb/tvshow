class CreateTvGroups < ActiveRecord::Migration
  def self.up
    create_table :tv_groups do |t|
      t.column :name, :string, :null => false
      t.column :description, :text
      t.column :image, :binary

      t.timestamps
    end
  end

  def self.down
    drop_table :tv_groups
  end
end