class Admin::UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ] 

  def index
    if params[:search].present?
      @pagy, @users = pagy(User.where(:role => 'user').global_search(params[:search]), items: 5)  
    else
      @pagy, @users = pagy(User.where(:role => 'user'), items: 5)
    end

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data User.all.to_csv, filename: "users-#{Date.today}.csv" }
    end
    
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
