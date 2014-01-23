class Provider < ActiveRecord::Base 
  belongs_to :user

  def self.find_or_create_from_omniauth(auth_hash)
    Provider.find_by(uid: auth_hash["uid"]) || create_from_omniauth(auth_hash)
  end

  def self.create_from_omniauth(auth_hash)
    user = User.new(username:auth_hash['info']['name'])
    provider = self.new(
      #setting user_id might not work bc this happens after the provider object is created
      # user_id: user.id,
      uid:      auth_hash["uid"],
      name: auth_hash["provider"],
      email:    auth_hash["info"]["email"],
      avatar_url: auth_hash["info"]["image"],
      username: auth_hash["info"]["nickname"]
    )
    user.providers << provider
    user.save!
    provider
  rescue ActiveRecord::RecordInvalid
    nil
  end

  def set_to_user
  end
end
