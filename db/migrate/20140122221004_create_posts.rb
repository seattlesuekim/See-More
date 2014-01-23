class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :author_id
      t.text :body
      t.string :title
      t.date :posted_at

      t.timestamps
    end
  end
end
