class UserAuthorization
  attr_writer :params_id

  def initialize(current_user_id, params_id)
    @current_user_id = current_user_id
    @params_id = params_id
  end

  def access?
    @current_user_id.to_i == @params_id.to_i
  end
end