require 'spec_helper'

describe SearchHelper do
  describe "#distance_formatter" do
    it "returns very close to you when the location is 0 or less miles" do
      helper.distance_formatter(0.1).should eq("Less than 1 mile away")
    end

    it "returns 1 mile away from you when the distance is 1 miles" do
      helper.distance_formatter(1.44).should eq("1 mile away")
    end

    it "returns x miles away when the distance is greater than 1 miles" do
      helper.distance_formatter(2).should eq("2 miles away")
    end
  end
end