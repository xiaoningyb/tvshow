class CreateTvPrograms < ActiveRecord::Migration
  def change
    create_table :tv_programs do |t|
      t.string :name
      t.string :description
      t.binary :image
      t.string :key_word
      t.integer :episode

      t.timestamps
    end
  end
end
