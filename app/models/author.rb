class Author < ActiveRecord::Base
 has_many :users, through: :user_authors
 has_many :user_authors
end

 