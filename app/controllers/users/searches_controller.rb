class Users::SearchesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.filtered_by(params.merge(user_id: current_user.id))
  end
end