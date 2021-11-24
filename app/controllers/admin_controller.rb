class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin_user
  
  private

  def verify_admin_user
    if current_user.user?
      redirect_to root_path
    end
  end
end
