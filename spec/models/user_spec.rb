require 'spec_helper'

describe User do
 subject { FactoryGirl.build(:user) }

  describe "validations" do
    it "validates the files can be attached" do
      subject.should have_attached_file(:avatar)
    end

    it "validates the presence of attachment" do
      subject.should validate_attachment_presence(:avatar)
    end

    it "validates the content type of the attachment" do
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

    it "validates presence of about me on create" do
      subject.about_me = ""
      subject.should have(1).error_on(:about_me)
    end
     it "validates presence of experience on create" do
      subject.experience = ""
      subject.should have(1).error_on(:experience)
    end

    it "validates presence of exercise type" do
      subject.exercise_type = ""
      subject.should have(1).error_on(:exercise_type)
    end

    it "validates presence of prefered times" do
      subject.prefered_time = ""
      subject.should have(1).error_on(:prefered_time)
    end
  end

  describe "scopes" do
    context "return all users except the current user" do
      
      before do
        subject { FactoryGirl.create(:user) }
        @user_two = FactoryGirl.create(:user, first_name: "Baz", email: "baz@gmail.com", gender: "Female", age: 18)
      end

      describe "#except_user" do
        it "returns all users execpt the current user" do
          User.except_user(subject).should eq([ @user_two ])
        end
      end

      context "based on gender" do
        describe "#gender" do
          it "returns all the users who match based on gender" do
            User.by_gender("Female").should eq([ @user_two ])
          end
        end
      end

      context "based on age" do
        before do
          @user_three = FactoryGirl.create(:user, age: 29)
        end
        describe "#age" do
          it "returns all the users who match based on age" do
            User.by_age('18..35').should eq([ @user_two, @user_three ])
          end

          it "returns all the users who match based on age" do
            User.by_age('64').should eq([ ])
          end
        end
      end

      context "based on experience level" do
        describe "#experience_level" do
          it "returns the users based on experience level" do
            User.experience_level("Beginner").should eq([ @user_two ])
          end

          it "doesnt return any users based on the experience level" do
            User.experience_level("Advanced").should eq([])
          end
        end
      end
      context "based on exercise type" do
        describe "#by_excercise_type" do
          it "returns the users based on excercise type" do
            User.by_exercise_type("Compound").should eq([ @user_two ])
          end

          it "doesnt return any users based on exercise type" do
            User.by_exercise_type("Flexiabilty").should eq([])
          end
        end
      end
    end
  end
end
