class User < ActiveRecord::Base
  # validates :username, presence: true
  has_many :providers
  has_many :authors, through: :user_authors, uniq: true
  has_many :user_authors

  def self.create_from_omniauth(auth_hash)
    self.create!(      
      username: auth_hash["info"]["name"],
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end

  def posts
    @posts = []
    self.authors.each do |author|
      author.posts.each do |post|
        @posts << post
      end
    end
    @posts
  end
  
end
