class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :username
      t.string :provider
      t.string :uid
      t.string :avatar

      t.timestamps
    end
  end
end
