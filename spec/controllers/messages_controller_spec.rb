require 'spec_helper'

describe MessagesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:message_params) { FactoryGirl.attributes_for(:message) }

  before do
    sign_in(:user, user)
    @user_two = FactoryGirl.create(:second_user)
  end
  
  describe "GET# new" do
    it "returns a success status for the page" do
      get :new, receiver_id: @user_two.id
      response.should be_ok
    end
  end

  describe "POST# create" do
    it "creates a new message with the correct params" do
      message_params.merge!(sender_id: user.id, screen_name: @user_two.screen_name)
      expect{ post :create, message: message_params
      }.to change( Message, :count ).by(1)
    end

    it "does not create a new message with incorrect params" do
      expect{ post :create, message: { subject: "", body: "" }
      }.to change( Message, :count ).by(0)
    end
  end
end