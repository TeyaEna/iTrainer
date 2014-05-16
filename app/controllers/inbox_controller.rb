class InboxController < ApplicationController
  before_filter :authenticate_user!

  def index
    @messages = Message.all_received_messages(current_user.id)
  end
end