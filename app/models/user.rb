class User < ActiveRecord::Base
  validates :username, presence: true
  has_many :providers

  def self.find_or_create_from_omniauth(auth_hash)
    User.find_by(email: auth_hash["info"]["email"], username: auth_hash['info']['name']) || create_from_omniauth(auth_hash)
  end

  def self.create_from_omniauth(auth_hash)
    self.create!(      
      username: auth_hash["info"]["name"],
      email:    auth_hash["info"]["email"],
    )
  rescue ActiveRecord::RecordInvalid
    nil
  end
  
end
