class Post < ActiveRecord::Base
  belongs_to :author
  attr_accessor :feed
end