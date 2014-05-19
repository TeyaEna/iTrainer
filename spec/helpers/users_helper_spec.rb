require 'spec_helper'

describe UsersHelper do
  
  it "returns a list of experience types" do
    helper.experience_types_list.should eq [ "Beginner", "Intermediate", "Advanced" ]
  end

  it "returns a list of exercise types" do
    helper.exercise_type_list.should eq ["Strength", "Flexibility", "Endurance"]
  end
end