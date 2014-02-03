class Post < ActiveRecord::Base
  validates :body, presence: :true
  belongs_to :author
  attr_accessor :feed

end