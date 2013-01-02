class CreateTvPrograms < ActiveRecord::Migration
  def self.up
    create_table :tv_programs do |t|
      t.column :name, :string, :null => false
      t.column :description, :text
      t.column :image, :binary
      t.column :key_word, :string
      t.column :episode, :integer

      t.timestamps
    end
  end

  def self.down
    drop_table :tv_programs
  end
end
