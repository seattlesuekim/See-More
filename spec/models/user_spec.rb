require 'spec_helper'

describe User do
  let(:user) { User.create( email: "a@bookis.com", username: "Bookis") }
  
  describe "validations" do
    it "is a valid user" do
      expect(user).to be_valid
    end
    
    it "requires a username" do
      user.username = nil
      expect(user).to be_invalid
    end

  end

  describe ".initialize_from_omniauth_twitter" do
    let(:user) { User.create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end

    context "when it's invalid" do
      it "returns nil" do
        user = User.create_from_omniauth({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end
  end

  describe ".initialize_from_omniauth_tumblr" do
    let(:user) {User.create_from_omniauth(OmniAuth.config.mock_auth[:tumblr]) }

    it "creates a valid user" do
      expect(user).to be_valid
    end


    context "when it's invalid" do
      it "returns nil" do
        user = User.create_from_omniauth({"uid" => "123", "info" => {}})
        expect(user).to be_nil
      end
    end
  end

  
end
