class User < ActiveRecord::Base
  # validates :username, presence: true
  has_many :providers
  has_many :authors, through: :user_authors, uniq: true
  has_many :user_authors

  def self.create_from_omniauth(auth_hash)
    self.create!(      
      username: auth_hash["info"]["name"],
      secret: auth_hash[:credentials][:secret], 
      token: auth_hash[:credentials][:token]
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end
  
end
