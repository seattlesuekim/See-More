class AddIdColumnToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pid, :string
  end
end
