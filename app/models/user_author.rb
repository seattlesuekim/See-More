class UserAuthor < ActiveRecord::Base
  belongs_to :user
  belongs_to :author
  validates  :user_id, uniqueness: { scope: :author_id }
end
