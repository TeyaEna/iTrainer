require 'spec_helper'

describe MessageHelper do
  let(:name) { "Faz"}

  describe "#screen_name_changer" do
    it "returns Me if the screen name is the same as the current user" do
      helper.screen_name_changer(name, name).should eq("Me")
    end

    it "returns the screen name of the not current user" do
      helper.screen_name_changer("Jack", name).should eq("Jack")
    end
  end
end