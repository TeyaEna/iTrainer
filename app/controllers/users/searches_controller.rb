class Users::SearchesController < ApplicationController
  before_filter :authenticate_user!, :convert_age_params_into_an_array

  def index
    @users = User.filtered_by(params.merge(user_id: current_user.id))
  end

  private 

  def convert_age_params_into_an_array
    if params[:age].present?
      ages = params[:age].split('..').map(&:to_i)
      if ages.count > 1
        ages = (ages.first..ages.last)
      end
    end
    params[:age] = ages.to_a
  end
end