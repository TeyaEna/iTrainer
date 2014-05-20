require 'spec_helper'

describe SearchesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_two) { FactoryGirl.create(:user, gender: "Female", age: 21) }
  let(:female_user) { FactoryGirl.create(:user, gender: "Female") }
  let(:other_user) { FactoryGirl.create(:user, first_name: "Geoff")}
  let(:young_user) { FactoryGirl.create(:user, age: 18)}
  let(:strong_user) { FactoryGirl.create(:user, exercise_type: "Strength")}
  let(:inexperienced_user) { FactoryGirl.create(:user, experience: "Beginner")}
  let(:all_options_user ) do 
   FactoryGirl.create(:user, exercise_type: "Strength", 
   experience: "Beginner", gender: "Female", age: 18)
  end
  
  before do
    sign_in(:user, user)
  end
  
  describe "#GET index" do
    it "gets the index page" do
      get 'index'
      response.should be_ok
    end

    context "based on given params" do

      context "searching based on gender" do
        it "returns back all the female users" do
          get 'index', gender: "Female"
          assigns(:users).should eq([ female_user ])
        end
      end
      
      context "searching based on age" do
        it "returns back all the users within a given range" do
          get 'index', age: 18
          assigns(:users).should eq([ young_user ])
        end
      end

      context "searching based on experience" do
        it "returns back all the users with a given experience" do
          get 'index', experience: "Beginner"
          assigns(:users).should eq([ inexperienced_user ])
        end
      end

      context "searching based on exercise type" do
        it "returns back all the users with a given exercise type" do
          get 'index', exercise: "Strength"
          assigns(:users).should eq([ strong_user ])
        end
      end

      context "searching based on both age, gender and experience level" do
        it "returns back all the users within a given range and gender" do
          get 'index', age: 18, gender: "Female", experience: "Beginner", exercise: "Strength"
          assigns(:users).should eq([ all_options_user ])
        end
      end
    end
  end
end