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
    click_link("Message")
    visit message_path(message.id)
    page.should have_content(message.body)
  end
end