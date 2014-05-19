require 'spec_helper'

describe SearchHelper do
  describe "#ommit_last_three_charecters" do
    it "removes last three digits of the poscode" do
      helper.ommit_last_three_characters("n17 7np").should eq("n17")
    end

    it "even when only two digits are entered" do
      helper.ommit_last_three_characters("n1").should eq("n1")
    end
  end
end