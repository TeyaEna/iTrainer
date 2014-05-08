require 'spec_helper'

describe UsersController do
  let(:user_params) { FactoryGirl.attributes_for(:user) }
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in(:user, user)
  end

  describe "GET #index" do
    it "responds with an 200 OK" do
      get :index
      response.should be_ok
    end

    context "all users except current user" do
      it "returns an array of users except the current user" do
        user_two = FactoryGirl.create(:user, first_name: "Baz", email: "baz@gmail.com")
        get :index
        assigns(:users).should include(user_two)
      end

      it "does not include the current user" do
        user_two = FactoryGirl.create(:user, first_name: "Baz", email: "baz@gmail.com")
        get :index
        assigns(:users).should_not include(user)
      end
    end
  end
end