require 'spec_helper'

feature "Viewing a message" do
  let(:user) { FactoryGirl.create(:user) }
  let(:second_user) { FactoryGirl.create(:user) }
  let!(:message) do 
    FactoryGirl.create(:message, receiver_id: user.id, 
      sender_id: second_user.id)
  end

  before do
    login_as(user)
  end

  scenario "by going clicking on a message link" do
    visit inbox_index_path
    click_link("Thread")
    visit message_path(message.id)
    page.should have_content(message.body)
  end

  context "when the user has an email sent to them" do
    scenario "replying to a message" do
      visit inbox_index_path
      click_link("Thread")
      visit message_path(message.id)
      fill_in "message-text", with: message.body
      click_button("Reply")
      page.should have_content("Message sent")
    end

    scenario "when no body is sent with the reply raise an error" do
      visit inbox_index_path
      click_link("Thread")
      visit message_path(message.id)
      fill_in "message-text", with: ""
      click_button("Reply")
      page.should have_content("There's an error on the reply")
    end
  end
end