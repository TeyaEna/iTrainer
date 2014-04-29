require 'spec_helper'


describe AdditionalInformationHelper do
  
  it "returns a list of prefered times" do
    helper.prefered_times_list.should eq [ "Early Morining (6-8am)", "Morining (9-11am)", "Mid Day (12-2pm)", "Daytime (3-6pm)", "Evening (7-10pm)"]
  end

  it "returns a list of experience types" do
    helper.experience_types_list.should eq [ "Beginner", "Intermediate", "Advanced" ]
  end

  it "returns a list of exercise types" do
    helper.exercise_type_list.should eq ["Strength", "Flexibility", "Endurance", "Flexibility"]
  end
end