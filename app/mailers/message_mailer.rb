class MessageMailer < ActionMailer::Base  

  def new_message(message)
    @message = Message.find(message[:id])
    mail(to: @message.receiver.email,  from: Rails.application.secrets.email_username,
      subject: @message.subject, body: @message.body, :content_type => "text/html")
  end
end

