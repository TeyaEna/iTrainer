require 'spec_helper'

feature "Message Inbox" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:second_user) { FactoryGirl.create(:user) }

  before do
    login_as(user)
    @message = FactoryGirl.create(:message, sender_id: second_user.id, receiver_id: user.id )
  end

  scenario "view message inbox" do
    visit root_path
    click_link("Inbox")
    visit inbox_index_path
    page.should have_content(@message.subject)
  end
end