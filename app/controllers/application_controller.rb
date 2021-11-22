class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?   

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name,:last_name ,:email, :password,:password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name,:last_name, :email, :password,:current_password])
  end

  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_users_path
    else
      root_path
    end
  end
end
