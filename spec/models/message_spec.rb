require 'spec_helper'

describe Message do
  subject { FactoryGirl.build(:message) }
  let(:user_attr) { FactoryGirl.attributes_for(:user) }

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
        @user = User.create(user_attr)
      end

      it "sets the receiver_id based on the screen name of the receiver" do
        subject.screen_name = "foobaz"
        subject.save
        subject.receiver_id.should eq(@user.id)  
      end
    end
  end
end