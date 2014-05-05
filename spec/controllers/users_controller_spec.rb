require 'spec_helper'

describe UsersController do
  let(:user_params) { FactoryGirl.attributes_for(:user) }

  describe "GET #index" do
    it "responds with an 200 OK" do
      get :index
      response.should be_ok
    end

    it "returns an array of users" do
      user = User.create(user_params)
      get :index
      assigns(:user).should eq [ user ]
    end
  end
end