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


    context "listing users" do
      before do
        @user = FactoryGirl.create(:user)
        @user_two = FactoryGirl.create(:user, first_name: "Baz", email: "baz@gmail.com", address: "N17 7NP")
      end
      context "all users except current user" do
        it "returns an array of users except the current user" do
          get :index
          assigns(:users).should include(@user_two)
        end

        it "does not include the current user" do
          get :index
          assigns(:users).should_not include(user)
        end
      end

      context "users closet to the current user" do
        it "orders the array of users by having the the closet in ascending order" do
          user_three = FactoryGirl.create(:user, first_name: "Baz", email: "bazc@gmail.com", address: "N16")
          get :index
          assigns(:users).should eq([ @user_two, user_three ])
        end
      end
    end
  end
end