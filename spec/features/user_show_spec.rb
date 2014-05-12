require 'spec_helper'

feature "User profile page" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
  end

  scenario "shows the users profile" do
    visit user_path(user)
    page.should have_content(user.screen_name)
  end
end