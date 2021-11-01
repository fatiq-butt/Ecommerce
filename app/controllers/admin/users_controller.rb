class Admin::UsersController < AdminController
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

  def edit;end

  def update
    if @user.update(user_params)
      flash[:notice] = "User Updated Successfully.."
      redirect_to users_path
    else
      flash[:errors] =  @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    respond_to do |format|
      @user.destroy
      format.js
    end  
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end  

end
