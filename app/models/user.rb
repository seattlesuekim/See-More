class User < ActiveRecord::Base
  # validates :username, presence: true
  has_many :providers
  has_many :authors, through: :user_authors, uniq: true
  has_many :user_authors
  # has_many :posts, through: :authors

  def self.create_from_omniauth(auth_hash)
    self.create!(      
      username: auth_hash["info"]["name"],
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end

  # def posts
  #   refactor code from user controller?
  # end
  
end
