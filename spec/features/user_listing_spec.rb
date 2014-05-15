require 'spec_helper'

feature "User listing" do
  let!(:current_user) { FactoryGirl.create(:user) }
  let!(:lady_user) { FactoryGirl.create(:user, gender: "Female") }
  let!(:young_user) { FactoryGirl.create(:user, age: 18) }
  let!(:faraway_user) { FactoryGirl.create(:user, address: "N17 7NP") }
  let!(:beginner_user) { FactoryGirl.create(:user, experience: "Beginner") }
  let!(:strong_user) { FactoryGirl.create(:user, exercise_type: "Strength") }

  before do
    login_as(current_user,scope: :user)
  end

  context "as the current user" do
    scenario "list users besides the user" do
      visit users_path
      page.should have_content(lady_user.screen_name)
      page.should have_content(young_user.screen_name)
      page.should_not have_content(faraway_user.screen_name)
      page.should_not have_content(current_user.screen_name)
    end
  
    context "searching based on criteria" do
      scenario "lists only female users" do
        visit users_path
        select "Female", from: 'gender'
        click_button("Filter")
        visit searches_path
        page.should have_content(lady_user.screen_name)
        page.should_not have_content(current_user.screen_name)
      end

      scenario "lists only users within an age range" do
        visit users_path
        select "18-35", from: 'age'
        click_button("Filter")
        visit searches_path
        page.should have_content(young_user.screen_name)
      end

      scenario "lists only users with a given experience level" do
        visit users_path
        select "Beginner", from: 'experience'
        click_button("Filter")
        visit searches_path
        page.should have_content(beginner_user.screen_name)
      end

      scenario "lists only users with a given exercise type" do
        visit users_path
        select "Strength", from: 'exercise'
        click_button("Filter")
        visit searches_path
        page.should have_content(strong_user.screen_name)
      end

      scenario "list only users within an age range, gender, experience level and exercise type" do
        ideal_match = FactoryGirl.create(:user, age: "18-35", gender: "Female")
        visit users_path
        select "18-35", from: 'age'
        select "Female", from: 'gender'
        select "Beginner", from: 'experience'
        select "Strength", from: 'exercise'
        click_button("Filter")
        visit searches_path
        page.should have_content(ideal_match.screen_name)
      end 
    end
  end
end