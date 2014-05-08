require 'spec_helper'

describe UsersController do
  let(:user_params) { FactoryGirl.attributes_for(:user) }
  let(:user) { FactoryGirl.create(:user, address: "N16") }

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
        @user_one = FactoryGirl.create(:user, address: "N16")
        @user_two = FactoryGirl.create(:user, first_name: "Baz", email: "baz@gmail.com", address: "N17 7NP")
      end
      context "all users except current user" do
        it "returns an array of users except the current user" do
          get :index
          assigns(:users).should eq([ @user_one, @user_two ])
        end

        it "does not include the current user" do
          get :index
          assigns(:users).should_not include(user)
        end
      end

      context "users closet to the current user" do
        it "orders the array of users by having the the closet in ascending order" do
          user_three = User.create(user_params)
          get :index
          assigns(:users).should eq([ @user_one, @user_two ])
        end
      end

      context "based on the gender provided by the user" do
        before do
          @user_f = FactoryGirl.create(:user, address: "N16", gender: "Female")
        end
        it "returns only the gender sent in the params" do
          post :index, gender: "Female"
          assigns(:users).should eq([ @user_f ])
        end
      end
    end
  end
end