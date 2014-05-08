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
    fill_in :user_about_me, with: user.about_me
    attach_file("Avatar", Rails.root + 'spec/fixtures/images/ruby.png')
    select "Beginner", from: :user_experience
    select "Strength", from: :user_exercise_type
    select "Early Morning (6-8am)", from: :user_prefered_time
    fill_in :user_prefered_place, with: user.prefered_place
    fill_in :user_address, with: "New York, NY" 
    click_button("Sign up")
    visit users_path
    page.has_css?("div.alert.alert-success", :text => "There was an error on the form")
  end

  scenario "filling in additional information to sign up form" do
    visit new_user_registration_path
    fill_in :user_last_name, with: user.last_name
    fill_in :user_screen_name, with: user.screen_name
    fill_in :user_email, with: user.email
    fill_in :user_password, with: user.password
    fill_in :user_password_confirmation, with: user.password_confirmation
    fill_in :user_about_me, with: user.about_me
    attach_file("Avatar", Rails.root + 'spec/fixtures/images/ruby.png')
    select "Early Morning (6-8am)", from: :user_prefered_time
    fill_in :user_prefered_place, with: user.prefered_place
    fill_in :user_address, with: "New York, NY" 
    click_button("Sign up")
    visit new_user_registration_path
    page.has_css?("div.alert.alert-error", :text => "There was an error on the form")
  end
end