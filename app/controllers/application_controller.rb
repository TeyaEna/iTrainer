class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def after_sign_in_path_for(resource)
    if resource.step?(2)
      edit_users_additional_path(resource.id)
    else
      users_path
    end
  end

  def configure_permitted_parameters
    [:first_name, :last_name, :screen_name, :gender, :age ].each do |attribute|
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
