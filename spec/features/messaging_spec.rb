require 'spec_helper'

feature "Messaging" do
  let(:user) { FactoryGirl.create(:user) }
  let(:user_two) { FactoryGirl.create(:user, first_name: "Bob") }
  let(:message) { FactoryGirl.create(:message) }

  before do
    login_as(user)
  end

  scenario "clickign a link on the users profile page to send them a message" do
    visit user_path(user_two)
    click_link("Send a message")
    visit new_message_path
    fill_in :message_subject, with: message.subject
    fill_in :message_body, with: message.body
    click_button("Send")
    visit users_path
    page.has_css?(css: "div.alert.alert-success", text: "Message sent")
  end
end