class CreateTvGroups < ActiveRecord::Migration
  def change
    create_table :tv_groups do |t|
      t.string :name
      t.string :description
      t.binary :image

      t.timestamps
    end
  end
end
