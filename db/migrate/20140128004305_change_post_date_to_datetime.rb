class ChangePostDateToDatetime < ActiveRecord::Migration
  def change
    rename_column :posts, :posted_at, :posted_at_date
    add_column :posts, :posted_at, :datetime

    Post.reset_column_information
    Post.find_each { |p| p.update_attribute(:posted_at, p.posted_at_date) }
    remove_column :posts, :posted_at_date
  end
end

 