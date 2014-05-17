require 'spec_helper'

describe UsersController do
  let(:user_params) { FactoryGirl.attributes_for(:user) }
  let(:current_user) { FactoryGirl.create(:user, address: "N16") }
  let(:user_one) { FactoryGirl.create(:user, address: "N16") }
  let(:user_two) { FactoryGirl.create(:user, address: "N17 7NP") }

  before do
    sign_in(:user, current_user)
  end

  describe "GET #index" do
    it "responds with an 200 OK" do
      get :index
      response.should be_ok
    end

    context "listing users" do
      context "all users except current user" do
        it "returns an array of users except the current user" do
          get :index
          assigns(:users).should eq([ user_one, user_two ])
        end

        it "does not include the current user" do
          get :index
          assigns(:users).should_not include(current_user)
        end
      end

      context "users closet to the current user" do
        it "orders the array of users by having the the closet in ascending order" do
          user_three = User.create(user_params)
          get :index
          assigns(:users).should eq([ user_one, user_two ])
        end
      end
    end

    describe "GET show" do
      it "responds with a success" do 
        get :show, { id: current_user.id }
        response.should be_ok
      end  
    end
  end
end