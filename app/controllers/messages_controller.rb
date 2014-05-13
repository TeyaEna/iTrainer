require 'base64'

class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @message = Message.new(receiver_params)
    @user = User.find(params[:receiver_id])
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      @message.save(message_params)
      redirect_to users_path
      flash[:success] = "Message sent"
    else 
      redirect_to request.referrer
      flash[:error] = "There's an error on the message form"
    end
  end

  private

  def message_params  
    params[:message].merge!({ sender_id: current_user.id})
    params.require(:message).permit(:subject, :body, :screen_name, :sender_id, :receiver_id)
  end

  def receiver_params
    params.permit(:receiver_id)
  end
end