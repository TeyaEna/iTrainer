require 'spec_helper'

describe RepliesController do
  let!(:sender) { FactoryGirl.create(:user) }
  let!(:receiver) { FactoryGirl.create(:user) }
  let(:message) { FactoryGirl.create(:message) }
  let(:valid_params) { FactoryGirl.attributes_for(:message, sender_id: sender.id, receiver_id: receiver.id) }
  let(:invalid_params) { { message: { subject: "", body: ""}  }}

  before do
    sign_in(:user, sender)
  end

  describe "POST #create" do
    before do
      request.env["HTTP_REFERER"] = message_path(message.id)
    end

    it "a new reply to a message" do
      expect { 
        post :create, message: valid_params
      }.to change( Message, :count).by(1)
    end

    it "doesn't create a reply to a message" do
      expect { 
        post :create, message: invalid_params
      }.to change( Message, :count).by(0)
    end

    it "returns the user back to the message path" do
      post :create, message: valid_params
      response.should redirect_to request.referer
    end
  end
end