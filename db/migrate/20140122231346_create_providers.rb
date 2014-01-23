class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :name
      t.string :uid
      t.integer :user_id
      t.string :avatar_url
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
