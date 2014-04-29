class UsersAdditionalController < ApplicationController

  def edit
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:about_me, workout_preferences_attributes: [:exercise_type, :experience, :prefered_times])
  end
end