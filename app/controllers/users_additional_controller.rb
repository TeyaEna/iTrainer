class UsersAdditionalController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.build_workout_preference
    if @user.update_attributes(user_params)
      redirect_to users_path
      flash[:success] = "Thanks for signing up"
    else
      flash[:error] = "There was an error on the form"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:about_me, workout_preference_attributes: [:exercise_type, :experience, :prefered_time, :prefered_place])
  end
end