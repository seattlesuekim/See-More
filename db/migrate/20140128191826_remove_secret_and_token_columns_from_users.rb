class RemoveSecretAndTokenColumnsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :token
    remove_column :users, :secret
  end
end
