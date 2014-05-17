require 'spec_helper'

describe User do
 subject { FactoryGirl.build(:user) }
 let(:current_user) { FactoryGirl.create(:user) }
 let(:params) { {user_id: current_user.id} }
 let(:female_user) { FactoryGirl.create(:user, gender: "Female") }
 let(:other_user) { FactoryGirl.create(:user, first_name: "Geoff")}
 let(:young_user) { FactoryGirl.create(:user, age: 18)}
 let(:strong_user) { FactoryGirl.create(:user, exercise_type: "Strength")}
 let(:inexperienced_user) { FactoryGirl.create(:user, experience: "Beginner")}
 let(:regular_user) { FactoryGirl.create(:user) }
 
 let(:all_options_user ) do 
   FactoryGirl.create(:user, exercise_type: "Strength", 
   experience: "Beginner", gender: "Female", age: 18)
 end

 let(:params_long) do
  { user_id: current_user.id, exercise: "Strength", 
    experience_level: "Beginner", gender: "Female", age: [18,19] }
 end

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
      describe "#except_user" do
        it "returns all users execpt the current user" do
          User.except_user(current_user).should eq([ other_user ])
        end
      end

      context "based on gender" do
        describe "#gender" do
          it "returns all the users who match based on gender" do
            User.by_gender("Female").should eq([ female_user ])
          end
        end
      end

      context "based on age" do
        describe "#age" do
          it "returns all the users who match based on age" do
            User.by_age([ 18, 29 ]).should eq([ young_user ])
          end

          it "returns all the users who match based on age" do
            User.by_age([ 64 ]).should eq([ ])
          end
        end
      end

      context "based on experience level" do
        describe "#experience_level" do
          it "returns the users based on experience level" do
            User.experience_level("Beginner").should eq([ inexperienced_user ])
          end

          it "doesnt return any users based on the experience level" do
            User.experience_level("Advanced").should eq([])
          end
        end
      end

      context "based on exercise type" do
        describe "#by_excercise_type" do
          it "returns the users based on excercise type" do
            User.by_exercise_type("Strength").should eq([ strong_user ])
          end

          it "doesnt return any users based on exercise type" do
            User.by_exercise_type("Flexiabilty").should eq([])
          end
        end
      end

      context "filtered by all options" do
        describe "#filtered_by" do
          it "returns all the users as no scopes have been applied" do
            User.filtered_by(params).should eq([ regular_user  ])
          end
          it "returns the matching users when scopes are applied" do
            User.filtered_by(params_long).should eq([ all_options_user ])
          end
        end
      end
    end
  end
end
