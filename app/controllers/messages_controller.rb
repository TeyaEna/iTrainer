class MessagesController < ApplicationController
  before_filter :authenticate_user!
  
  def new
    @message = Message.new
    @user = User.find(params[:receiver_id])
  end

  def create
    @message = Message.new(message_params)
    @message.sender = current_user
    @message.receiver_id = User.find_by_screen_name(params[:message][:screen_name]).id

    if @message.valid?
      @message.save
      redirect_to users_path
      flash[:success] = "Message sent"
    else 
      redirect_to request.referrer
      flash[:error] = "There's an error on the message form"
    end
  end

  private

  def message_params
    params.require(:message).permit(:subject, :body)
  end

end