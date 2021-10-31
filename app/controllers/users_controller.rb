class UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ] 

  def index
    if params[:order].present?
        @pagy, @users = pagy(User.where(role:'user').order(params[:sort] => params[:order]), items: 5)
    elsif params[:search].present?
        @pagy, @users = pagy(User.where(role: 'user').global_search(params[:search]), items: 5)
    else
      @pagy, @users = pagy(User.where(role:'user'), items: 5)
    end

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data @users.to_csv, filename: "users-#{Date.today}.csv" }
    end
      
  end

  def show;end

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
