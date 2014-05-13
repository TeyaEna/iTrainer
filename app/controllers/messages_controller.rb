class MessagesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @message = Message.new(receiver_params)
  end

  def create
    @message = Message.create(message_params)
    if @message.save
      redirect_to users_path
      flash[:success] = "Message sent"
    else 
      render "new"
      flash[:error] = "There's an error on the message form"
    end
  end

  private

  def message_params
    params.merge(sender_id: current_user.id)
    params.require(:message).permit(:subject, :body, :receiver_id, :sender_id)
  end

  def receiver_params
    params.permit(:receiver_id)
  end
end