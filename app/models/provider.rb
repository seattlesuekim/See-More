class Provider < ActiveRecord::Base 
  validates :name, presence: true
  validates :uid, presence: true
  validates :username, presence: true
  validates :avatar_url, presence: true
  # validates :secret, presence: true # not included in instagram
  validates :token, presence: true

  belongs_to :user
# can remove email column from providers table
  def self.find_or_create_from_omniauth(auth_hash)
    Provider.find_by(uid: auth_hash[:uid], name: auth_hash[:provider]) || create_from_omniauth(auth_hash)
  end

  def self.create_from_omniauth(auth_hash)
    Provider.create!(
      uid:        auth_hash[:uid],
      name:       auth_hash[:provider],
      avatar_url: auth_hash[:info][:image] || auth_hash[:info][:avatar],
      username:   auth_hash[:info][:nickname],
      secret:     auth_hash[:credentials][:secret], 
      token:      auth_hash[:credentials][:token]
    )
    
  rescue ActiveRecord::RecordInvalid
    nil
  end

end
