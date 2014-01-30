require 'spec_helper'

describe Provider do
  let(:provider) { Provider.create( name: "twitter", uid: "1234", username: "Bookis", email: 'bookis@bookis.com', avatar_url: "some_string") }

  describe 'validations' do
    it 'creates a valid provider' do
      provider = Provider.create
      expect(provider).to_not be_valid
    end
  end

  describe '.initialize_from_omniauth_twitter' do
    let(:provider) { Provider.create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }
    
    it "creates a valid provider" do
      expect(provider).to be_valid
    end
  end

  describe '.initialize_from_omniauth_tumblr' do
    let(:provider) { Provider.create_from_omniauth(OmniAuth.config.mock_auth[:tumblr]) }

    it "creates a valid user" do
      expect(provider).to be_valid
    end
  end

end
