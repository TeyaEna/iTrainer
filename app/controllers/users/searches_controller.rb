class Users::SearchesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.except_user(current_user.id).gender(params[:gender]).age(params[:gender])
  end
end