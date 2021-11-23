class Admin::UsersController < AdminController
  before_action :authenticate_user!
  before_action :find_user, only: %i[show edit update destroy]

  def index
    if params[:search].present?
      @users = User.user.global_search(params[:search])
    else
      @users = User.user
    end  
    @pagy, @users = pagy(@users, items: 5)
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.js
    end  
  end

  private 

  def find_user
    @user = User.find(params[:id])
  end  
end
