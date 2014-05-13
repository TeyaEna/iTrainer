require 'spec_helper'

describe MessagesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:message_params) { FactoryGirl.attributes_for(:message) }
  let(:invalid_params) { { message: { subject: "", body: ""}  }}
  let(:user_two) { FactoryGirl.create(:second_user) }

  before do
    sign_in(:user, user)
  end
  
  describe "GET# new" do
    it "returns a success status for the page" do
      get :new, receiver_id: user_two.id
      response.should be_ok
    end
  end

  describe "POST# create" do
    it "creates a new message with the correct params" do
      message_params.merge!(sender_id: user.id, screen_name: user_two.screen_name)
      expect{ post :create, message: message_params
      }.to change( Message, :count ).by(1)
    end

    context "when incorrect params are entered" do
      before do
        request.env["HTTP_REFERER"] = new_message_path(user_two)
      end

      it "does not create a new message with incorrect params" do
        expect{ post :create, invalid_params
        }.to change( Message, :count ).by(0)
      end

      it "goes back to the previous page if there are errors on the form" do
        post :create, invalid_params
        response.should redirect_to request.referer
      end
    end
  end
end