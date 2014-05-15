class SearchesController < ApplicationController
  before_filter :authenticate_user!, :convert_age_params_into_an_array

  def index
    @users = User.filtered_by(params.merge(user_id: current_user.id))
  end

  private 

  def convert_age_params_into_an_array
    if params[:age].present?
      bounds = params[:age].split('..').map(&:to_i)
      if bounds.count > 1
        ages = (bounds.first..bounds.last)
      end
    end
    params[:age] = ages
  end
end