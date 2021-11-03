class Admin::UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ] 

  def index
    @pagy, @users = pagy(User.where(:role => 'user'), items: 5)
  end

  def destroy
    respond_to do |format|
      @user.destroy
      format.js
    end  
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end  
end
