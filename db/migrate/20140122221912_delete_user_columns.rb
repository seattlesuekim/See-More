class DeleteUserColumns < ActiveRecord::Migration
  def change
    remove_column :users, :uid
    remove_column :users, :provider
    remove_column :users, :avatar_url

  end
end
