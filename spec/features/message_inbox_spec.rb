require 'spec_helper'

feature "Message Inbox" do
  let(:user) { FactoryGirl.create(:message) }

  scenario "view message index" do
    visit messages_inboxes_path
  end
end