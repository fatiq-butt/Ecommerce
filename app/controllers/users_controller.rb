class UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ] 

  def index
    @users = User.where(:role => 'user')
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
