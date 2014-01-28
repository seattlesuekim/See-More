class AddSecretAndTokenColumnsToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :token, :string
    add_column :providers, :secret, :string
  end
end
