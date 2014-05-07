require 'spec_helper'
require './lib/user_authorization'


describe UserAuthorization  do
  subject { UserAuthorization.new(3, 3) }
  describe "#access?" do
    it "returns true if the user can access the page" do
      subject.access?.should eq true
    end

    it "returns false if the user can't access the page" do
      subject.params_id = 4
      subject.access?.should eq false
    end
  end
end