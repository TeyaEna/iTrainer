require 'spec_helper'

describe Message do
  subject { FactoryGirl.build(:message) }
  let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:second_user) }
 
  describe "validations" do
    it "a blank subject raises a validation error" do
      subject.subject = ''
      subject.should have(1).error_on(:subject)
    end

    it "a blank body raises a validation error" do
      subject.body = ''
      subject.should have(1).error_on(:body)
    end

    describe "scopes" do
      before do
        attributes = {receiver_id: second_user.id, sender_id: user.id }
        @message_one = FactoryGirl.create(:message, attributes)
        @message_two = FactoryGirl.create(:message, attributes)
      end
      describe "received_messages" do
        it "returns a list of messages in ascending oreder" do
          Message.received_messages(second_user.id).should eq([ @message_one, @message_two ])
        end
      end
    end
  end
end