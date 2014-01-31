require 'spec_helper'

describe SessionsController do

describe SessionsController do
  describe "GET 'create'" do
    context "when using twitter authorization" do
      context "is successful" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }

        it "redirects to home page" do
          get :create, provider: :twitter
          expect(response).to redirect_to root_path
        end

        it "creates a user" do
          expect { get :create, provider: :twitter }.to change(User, :count).by(1)
        end

        it "assigns the @user var" do
          get :create, provider: :twitter
          expect(assigns(:user)).to be_an_instance_of User
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :twitter
          expect(session[:user_id]).to eq assigns(:user).id
        end

      end

      context "when the user has already signed up" do
        before { request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:twitter] }
        let!(:user) { User.find_or_create_from_omniauth(OmniAuth.config.mock_auth[:twitter]) }

        it "doesn't create another user" do
          expect { get :create, provider: :twitter }.to_not change(User, :count).by(1)
        end

        it "assigns the session[:user_id]" do
          get :create, provider: :twitter
          expect(session[:user_id]).to eq user.id
        end
      end

      context "fails on github" do
        before { request.env["omniauth.auth"] = :invalid_credential }

        it "redirect to home with flash error" do
          get :create, provider: :twitter
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to include "Failed to authenticate"
        end
      end

      context "when failing to save the user" do
        before { 
          request.env["omniauth.auth"] = {"uid" => "1234", "info" => {}}
        }

        it "redirect to home with flash error" do
          get :create, provider: :twitter
          expect(response).to redirect_to root_path
          expect(flash[:notice]).to include "Failed to save the user"
        end
      end
    end
  end
end
end
