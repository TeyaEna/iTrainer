require 'spec_helper'

describe Message do
  subject { FactoryGirl.build(:message) }
  let(:user) { FactoryGirl.attributes_for(:user) }
  let(:second_user) { FactoryGirl.attributes_for(:second_user) }
 
  describe "validations" do
    it "a blank subject raises a validation error" do
      subject.subject = ''
      subject.should have(1).error_on(:subject)
    end

    it "a blank body raises a validation error" do
      subject.body = ''
      subject.should have(1).error_on(:body)
    end

    context "screen name validation" do
      before do
        @user = FactoryGirl.create(:user)
      end

      it "sets the receiver_id based on the screen name of the receiver" do
        subject.screen_name = "foobaz"
        subject.save
        subject.receiver_id.should eq(@user.id)  
      end
    end

    describe "scopes" do
      before do
        @user = User.create(user)
        @second_user = User.create(second_user)
        subject do
          Message.create(:message, receiver_id: @second_user.id, 
            sender_id: @user.id, screen_name: @second_user.screen_name )
        end
        @message_two_params = FactoryGirl.attributes_for(:second_message, receiver_id: @second_user.id, sender_id: @user.id, screen_name: @second_user.screen_name)
        @message_two = Message.create(@message_two_params)
      end
      describe "received_messages" do
        it "returns a list of messages in ascending oreder" do
          Message.received_messages(@second_user.id).should eq([ subject, @message_two ])
        end
      end
    end
  end
end