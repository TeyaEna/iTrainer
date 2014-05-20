class InboxController < ApplicationController
  before_filter :authenticate_user!

  def index
    @messages = Message.all_received_messages(current_user.id).page(params[:page]).per(10)
  end
end