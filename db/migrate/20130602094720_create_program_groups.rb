class CreateProgramGroups < ActiveRecord::Migration
  def change
    create_table :program_groups do |t|
      t.string :name
      t.string :description
      t.binary :image
      t.string :key_word
      t.integer :group_type
      t.time :interval
      t.integer :total_episode

      t.timestamps
    end
  end
end
