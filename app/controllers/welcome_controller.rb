class WelcomeController < ApplicationController
  def home
    @main_feed = []
    Post.all.each do |post|
      @main_feed << post
    end
    @main_feed
  end
end
