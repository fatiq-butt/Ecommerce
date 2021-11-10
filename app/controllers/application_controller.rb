class ApplicationController < ActionController::Base
  include Pagy::Backend
  
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?   

  protected

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name,:last_name ,:email, :password,:password_confirmation)}
     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name,:last_name, :email, :password, :password_confirmation, :current_password)}
  end
  
  def after_sign_in_path_for(resource)
    if current_user.admin?
      admin_users_path
    elsif current_user.user? && current_user.invited_user 
      flash[:notice] = "Change your password to something you will remember"
      edit_user_registration_path
    else
      root_path
    end    
  end
end
