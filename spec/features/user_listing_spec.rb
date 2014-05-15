require 'spec_helper'

feature "User listing" do
  let(:user) { FactoryGirl.create(:user) }

  before do
    login_as(user,scope: :user)
  end

  context "as the current user" do
    before do
      @user_two = FactoryGirl.create(:second_user)
    end
    scenario "list users besides the user" do
      visit users_path
      page.should have_content(@user_two.screen_name)
      page.should_not have_content(user.screen_name)
    end
  
    context "searching based on criteria" do
      scenario "lists only female users" do
        visit users_path
        select "Female", from: 'gender'
        click_button("Filter")
        visit searches_path
        page.should have_content(@user_two.screen_name)
        page.should_not have_content(user.screen_name)
      end

      scenario "lists only users within an age range" do
        visit users_path
        select "18-35", from: 'age'
        click_button("Filter")
        visit searches_path
        page.should have_content(@user_two.screen_name)
      end

      scenario "lists only users with a given experience level" do
        visit users_path
        select "Beginner", from: 'experience'
        click_button("Filter")
        visit searches_path
        page.should have_content(@user_two.screen_name)
      end

      scenario "lists only users with a given exercise type" do
        visit users_path
        select "Strength", from: 'exercise'
        click_button("Filter")
        visit searches_path
        page.should have_content(@user_two.screen_name)
      end

      scenario "list only users within an age range, gender, experience level and exercise type" do
        visit users_path
        select "18-35", from: 'age'
        select "Female", from: 'gender'
        select "Beginner", from: 'experience'
        select "Strength", from: 'exercise'
        click_button("Filter")
        visit searches_path
        page.should have_content(@user_two.screen_name)
      end 
    end
  end
end