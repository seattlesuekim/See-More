class ChangeProviderToType < ActiveRecord::Migration
  def change
    rename_column :authors, :provider, :type
  end
end
