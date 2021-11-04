class Admin::UsersController < AdminController
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

  def new
    @user = User.new     
  end  

  def create
    @user = User.new(user_params)
    @password = Devise.friendly_token.first(Devise.password_length.first)
    @user.password = @password
    @user.password_confirmation = @password
    @user.skip_password_validation = true
    
    InviteMailer.with(user: @user, password: @password).invite_created.deliver_now
    @user.skip_confirmation!
    if @user.save
      redirect_to admin_users_path , notice: "Invite email sent successfully"
    end
  end

  private 

  def set_user
    @user = User.find(params[:id])
  end  

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role)
  end
end
