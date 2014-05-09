require 'spec_helper'

describe Users::SearchesController do
  let(:user) { FactoryGirl.create(:user) }
  before do
    sign_in(:user, user)
  end
  describe "#GET index" do
    it "gets the index page" do
      get 'index'
      response.should be_ok
    end
  end

  describe "#POST index" do
    before do
      @user_two = FactoryGirl.create(:user, gender: "Female")
    end
    context "searching based on gender" do
      it "returns back all the female users" do
        get 'index', gender: "Female"
        assigns(:users).should eq([ @user_two])
      end
    end
  end
end