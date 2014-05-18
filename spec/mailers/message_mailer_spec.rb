require 'spec_helper'

describe MessageMailer do
  let(:receiving_user) { FactoryGirl.create(:user) }
  let(:sending_user) { FactoryGirl.create(:user) }
  let(:message) { FactoryGirl.create(:message, receiver_id: receiving_user.id, sender_id: sending_user.id) }
  let(:new_message) { MessageMailer.new_message(message) }

  before do
    ActionMailer::Base.deliveries = []
  end

  describe "#new_message" do
    it "renders the correct subject, to, from for new messages" do
      new_message.subject.should eq(message.subject)
      new_message.to.should.should eq([receiving_user.email])
      new_message.from.should eq([Rails.application.secrets.email_username])
    end

    it "sends the email when an new message is sent" do
      new_message.deliver
      ActionMailer::Base.deliveries.should include(new_message)
    end  

    it "contain this body in the email for sent message" do
      new_message.body.should include(message.body)
    end
  end
end