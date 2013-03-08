class CreateDiscussComments < ActiveRecord::Migration
  def change
    create_table :discuss_comments do |t|
      t.integer :discuss_id
      t.integer :user_id
      t.integer :comment_type
      t.text    :content

      t.timestamps
    end
  end
end
