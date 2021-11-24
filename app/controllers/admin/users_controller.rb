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
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.js
    end  
  end

  def new
    @user = User.new     
  end  

  def create
    @user = User.new(user_params)
    @password = User.generate_random_password
    @user.password = @password
    @user.password_confirmation = @password
    @user.invited_user = true
    @user.skip_confirmation!    
    if @user.save
      InviteMailer.with(user: @user, password: @password).invite_created.deliver_now
      redirect_to admin_users_path , notice: "Invite email sent successfully"
    end
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end  

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
