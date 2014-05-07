require 'spec_helper'

describe UsersController do
  let(:user_params) { FactoryGirl.attributes_for(:user) }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET #index" do
    it "responds with an 200 OK" do
      get :index
      response.should be_ok
    end

    it "returns an array of users" do
      get :index
      assigns(:user).should include(user)
    end
  end
end