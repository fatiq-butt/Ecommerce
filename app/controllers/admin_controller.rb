class AdminController < ApplicationController
  before_action :admin_only
  before_action :authenticate_user!
  
  private

  def admin_only
    if current_user.user?
      redirect_to root_path
    end
  end
  
end
