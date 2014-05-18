class ApplicationController < ActionController::Base
  PERMITTED_ATTRIBUTES = [:first_name, :last_name, :screen_name, :gender, :age,  :about_me, :address, :avatar, :latitude, :longitude, 
  :exercise_type, :experience, :prefered_time, :prefered_place ].freeze

  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
    users_path
  end

  def configure_permitted_parameters
    PERMITTED_ATTRIBUTES.each do |attribute|
      devise_parameter_sanitizer.for(:sign_up) << attribute
    end
  end

  def layout_by_resource
    if devise_controller?
      'not_signed_in'
    else
      'application'
    end
  end
end
