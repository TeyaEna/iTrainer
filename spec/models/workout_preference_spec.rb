require 'spec_helper'

describe WorkoutPreference do
  subject { FactoryGirl.create(:workout_preference) }
  
  describe "validations" do
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
end