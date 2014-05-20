require 'spec_helper'

describe InboxController do

  let(:receiver) { FactoryGirl.create(:user) }
  let(:sender) { FactoryGirl.create(:user) }
  let!(:message) { FactoryGirl.create(:message, receiver: receiver, sender: sender)}

  before do
    sign_in(:user, receiver)
  end

  describe "GET# index" do
    it "responsds successuflly" do
      get :index
      response.should be_ok
    end

    it "retrieves all the users messages" do
      get :index
      assigns(:messages).should eq([ message ])
    end 
  end
end