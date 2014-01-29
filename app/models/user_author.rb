class UserAuthor < ActiveRecord::Base
  belongs_to :user
  belongs_to :author
  validates  :user_id, uniqueness: { scope: :author_id }
  has_many :posts, through: :authors
end
