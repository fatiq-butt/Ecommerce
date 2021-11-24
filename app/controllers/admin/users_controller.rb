class Admin::UsersController < AdminController
  before_action :authenticate_user!
  before_action :find_user, only: %i[show edit update destroy]

  def index
    users = User.user
    users = users.global_search(params[:search]) if params[:search].present?
    users = users.order(params[:sort] => params[:order]) if params[:order].present?
    @pagy, @users = pagy(users, items: 5)

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data CsvGenerationService.new('User').call, filename: "users-#{Date.today}.csv" }
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = "User Updated Successfully.."
      redirect_to admin_users_path
    else
      flash[:errors] =  @user.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.js
    end  
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end  
end
