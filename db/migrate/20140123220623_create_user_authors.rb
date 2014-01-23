class CreateUserAuthors < ActiveRecord::Migration
  def change
    create_table :user_authors do |t|
      t.integer :user_id
      t.integer :author_id

      t.timestamps
    end
  end
end
