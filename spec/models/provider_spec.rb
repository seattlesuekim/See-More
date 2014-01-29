require 'spec_helper'

describe Provider do
  # let(:provider) { Provider.create( name: "twitter", uid: "1234", username: "Bookis", email: 'bookis@bookis.com', avatar_url: "some_string") }

  describe 'validations' do
    it 'creates a valid provider' do
      provider = Provider.create
      expect(provider).to_not be_valid
    end
  end
end
