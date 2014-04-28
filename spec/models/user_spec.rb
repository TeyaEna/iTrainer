require 'spec_helper'

describe User do
 subject { FactoryGirl.build(:user) }

  describe "validations" do
    it "validates the presence of the avatar" do
      subject.step = "2nd step"
      subject.should have_attached_file(:avatar)
    end

    it "validates the content type of the attachment" do
      subject.step = "2nd step"
      subject.should validate_attachment_content_type(:avatar).
                allowing('image/png', 'image/gif').
                rejecting('text/plain', 'text/xml')
    end

    it "validates password length" do
      subject.password = '12abc'
      subject.should have(1).error_on(:password)
    end

    it "validates password confirmation" do
      subject.password_confirmation = '12a'
      subject.should have(1).error_on(:password_confirmation)
    end

    it "validates email" do
      subject.email = 'abcd'
      subject.should have(1).error_on(:email)
    end

    it "validates presence of age" do
      subject.age = ""
      subject.should have(1).error_on(:age)
    end

    it "validates presence of gender" do
      subject.gender = ""
      subject.should have(1).error_on(:gender)
    end

    it "validates presence of screen name" do
      subject.screen_name = ""
      subject.should have(1).error_on(:screen_name)
    end

    it "validates format of first name" do
      subject.first_name = "abc123G"
      subject.should have(1).error_on(:first_name)
    end

    it "validates format of last name" do
      subject.last_name = "234gjg"
      subject.should have(1).error_on(:last_name)
    end

    it "validates presence of experience on create" do
      subject.experience = ""
      subject.step = "2nd step"
      subject.should have(1).error_on(:experience)
    end

    it "validates presence of about me on create" do
      subject.about_me = ""
      subject.step = "2nd step"
      subject.should have(1).error_on(:about_me)
    end
  end
end
