require 'base64'

module ApplicationHelper
  def encode_user_params(user_id)
    Base64.encode64("#{user_id}")
  end

  def decode_user_params(user_id)
     Base64.decode64("#{user_id}")
  end
end
