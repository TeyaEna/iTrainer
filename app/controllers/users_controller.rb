class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.except_user(current_user.id)
  end
end