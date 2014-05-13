require 'spec_helper'

feature "Messaging" do
  let(:user) { FactoryGirl.create(:user) }
  let(:message) { FactoryGirl.build(:message) }
  let(:user_two) { FactoryGirl.create(:second_user) }

  before do
    login_as(user)
    @user_two = FactoryGirl.create(:second_user) 
  end

  scenario "clicking a link on the users profile page to send them a message" do
    visit user_path(@user_two.id)
    click_link("Send a message")
    new_message_path(receiver_id: @user_two.id)
    fill_in :message_subject, with: message.subject
    fill_in :message_body, with: message.body
    click_button("Send")
    visit users_path
    page.has_css?(css: "div.alert.alert-success", text: "Message sent")
  end

  scenario "when the subject and body fields are left empty an error is raised" do
    visit user_path(@user_two.id)
    click_link("Send a message")
    new_message_path(receiver_id: @user_two.id)
    fill_in :message_subject, with: ""
    fill_in :message_body, with: ""
    click_button("Send")
    visit users_path
    page.has_css?(css: "div.alert.alert-error", text: "There's an error on the message form")
  end
end