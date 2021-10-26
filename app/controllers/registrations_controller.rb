class RegistrationsController < Devise::RegistrationsController
  before_action :check_resource, only: [:create]
  def new
    build_resource
    respond_to do |format|
      format.js
    end    
  end  
  def check_resource
    build_resource(sign_up_params)  
    unless resource.validate
      flash[:errors] = resource.errors.full_messages
      render "devise/sessions/new"
    end       
  end
end
