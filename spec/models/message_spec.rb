require 'spec_helper'

describe Message do
  let(:message) { FactoryGirl.create(:message) }

  describe "validations" do
    it "a blank subject raises a validation error" do
      subject.subject = ''
      subject.should have(1).error_on(:subject)
    end

    it "a blank body raises a validation error" do
      subject.body = ''
      subject.should have(1).error_on(:body)
    end
  end
end