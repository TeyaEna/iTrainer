class RepliesController < ApplicationController

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    if @message.valid?
      @message.save
      flash[:success] = "Message sent"
    else 
      flash[:error] = "There's an error on the reply"
    end
    redirect_to request.referrer
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body, :receiver_id)
  end
end