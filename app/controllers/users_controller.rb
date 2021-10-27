class UsersController < AdminController
  def index
    @users = User.where(:role => 'user')
  end

  def destroy
    @user = User.find(params[:id])
    respond_to do |format|
      @user.destroy
      format.js
    end  
  end  
end
