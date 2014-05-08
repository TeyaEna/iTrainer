require 'spec_helper'

feature "User listing" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user,scope: :user)
  end

  context "as the current user" do
    before do
      @user = FactoryGirl.create(:user, screen_name: "Baz", email: "baz@gmail.com")
    end
    scenario "list users besides the user" do
      visit users_path
      page.should have_content(@user.screen_name)
      page.should_not have_content(user.screen_name)
    end
  end
end