class UsersAdditionalController < ApplicationController

  def edit
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render file: "#{Rails.root}/public/404", status: 404
    end
  end

  def update
    @user = User.find(params[:id])
    @user.build_workout_preference(workout_params)
    if @user.update_attributes(user_params)
      flash[:success] = "Thanks for signing up"
      redirect_to users_path
    else
      flash[:error] = "There was an error on the form"
      render :edit
    end
  end

  private

  def workout_params
    unless params[:user][:workout_preferences].nil?
     params[:user][:workout_preferences].permit(:exercise_type, :experience, :prefered_time, :prefered_place, :user_id)
    end
  end 

  def user_params
    params.require(:user).permit(:about_me, workout_preference_attributes: [:exercise_type, :experience, :prefered_time, :prefered_place, :user_id])
  end
end