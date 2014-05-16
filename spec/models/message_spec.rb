require 'spec_helper'

describe Message do
  subject { FactoryGirl.build(:message) }
  let(:receiving_user) { FactoryGirl.create(:user) }
  let(:sending_user) { FactoryGirl.create(:user) }
  let(:receiver) { {receiver_id: receiving_user.id, sender_id: sending_user.id} }
  let(:sender) { {sender_id: receiving_user.id, receiver_id: sending_user.id  } }
 
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
      context "as the receiving user" do
        before do
          @message_one = FactoryGirl.create(:message, receiver)
          @message_two = FactoryGirl.create(:second_message, receiver)
        end
        describe "received_messages" do
          it "returns a list of messages in ascending oreder" do
            Message.all_received_messages(receiving_user.id).should eq({ sending_user.id => [ @message_two, @message_one ] })
          end

          it "does not return any messages as there none which match" do
            Message.all_received_messages(sending_user.id).should eq({})
          end
        end

        describe "#received_messages" do
          it "returns all the received messages based on sender_id and receiver_id" do
            Message.received_messages(receiving_user.id, sending_user.id).should eq([ @message_two, @message_one ])
          end

          it "doesn't return any results for received messages" do
            Message.received_messages(sending_user.id, receiving_user.id).should eq([ ])
          end
        end
      end

      describe "#sent_messages" do
        before do
          @message = FactoryGirl.create(:message, sender)
        end
        it "returns all the received messages based on sender_id and receiver_id" do
          Message.sent_messages(receiving_user.id, sending_user.id).should eq([ @message ])
        end

        it "doesn't return any results for sent messages" do
          Message.sent_messages(sending_user.id, receiving_user.id).should eq([ ])
        end
      end
    end
  end
end