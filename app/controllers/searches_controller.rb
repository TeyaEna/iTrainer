class SearchesController < ApplicationController
  before_filter :authenticate_user!, :convert_age_params_into_an_array

  def index
    @users = User.filtered_by(params.merge(user_id: current_user.id))
  end

  private 

  def convert_age_params_into_an_array
    if params[:age].present?
      bounds = params[:age].split('..').map(&:to_i)
      ages = bounds.count > 1 ? (bounds.first..bounds.last) : bounds
    end
    params[:age] = ages
  end
end