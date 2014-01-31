class Provider < ActiveRecord::Base 
  validates :name, presence: true
  validates :uid, presence: true
  validates :username, presence: true
  validates :avatar_url, presence: true
  validates :email, presence: true
  validates :secret, presence: true
  validates :token, presence: true

  belongs_to :user
  # validate all attribute fields

  def self.find_or_create_from_omniauth(auth_hash)
    Provider.find_by(uid: auth_hash["uid"], name: auth_hash['provider']) || create_from_omniauth(auth_hash)
  end

  def self.create_from_omniauth(auth_hash)
    Provider.create!(
      uid:        auth_hash["uid"],
      name:       auth_hash["provider"],
      email:      auth_hash["info"]["email"],
      avatar_url: auth_hash["info"]["image"],
      username:   auth_hash["info"]["nickname"],
      secret:     auth_hash[:credentials][:secret], 
      token:      auth_hash[:credentials][:token]
    )
    # all of this might need to be an extra step to link, rather than create new user
    # user = User.new(username:auth_hash['info']['name'], email: auth_hash['info']['email'])
    #this automatically saves the user and the provider in one move 
    #(prevents user from being saved if the provider does not get saved)
    # user.providers << provider 
    # user.save!
    # provider
  rescue ActiveRecord::RecordInvalid
    nil
  end

end
