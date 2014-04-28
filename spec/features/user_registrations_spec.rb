require 'spec_helper'

feature "User Registration" do
  let(:user) { FactoryGirl.create(:user) }

  scenario "sign up with corret data" do
    visit new_user_registration_path
    fill_in :user_first_name, with: user.first_name
    fill_in :user_last_name, with: user.last_name
    fill_in :user_screen_name, with: user.screen_name
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password_confirmation
    select "18", from: :user_age
    select "Male", from: :user_gender
    click_button("Sign up")
  end
end