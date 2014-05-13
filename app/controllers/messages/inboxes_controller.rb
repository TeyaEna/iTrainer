class Messages::InboxesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @messages = Message.received_messages(current_user.id)
  end
end