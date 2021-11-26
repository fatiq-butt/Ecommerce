class Admin::UsersController < AdminController
  include FilterRecords

  before_action :authenticate_user!
  before_action :find_user, only: %i[show edit update destroy]

  def index
    @pagy, @users = sort_page_filter(User)

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
      redirect_to admin_users_path, notice: "User Updated Successfully."
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
    @user.set_user_invitation(@password)
    if @user.save
      InviteMailer.with(user: @user, password: @password).invite_created.deliver_now
      redirect_to admin_users_path, notice: "Invite email sent successfully"
    end
  end

  private 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find_by(id: params[:id])
    redirect_to admin_users_path unless @user
  end  

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
