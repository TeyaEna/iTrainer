require 'spec_helper'

describe InboxController do

  before do
    @user = FactoryGirl.create(:user)
    sign_in(:user, @user)
    @user_two = double("user_two", id: 2)
    @message = FactoryGirl.create(:message, receiver_id: @user.id, sender_id: @user_two.id)
  end

  describe "GET# index" do
    it "responsds successuflly" do
      get :index
      response.should be_ok
    end

    it "retrieves all the users messages" do
      get :index
      assigns(:messages).should eq( { @user_two.id => [ @message ]} )
    end 
  end
end