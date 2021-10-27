class UsersController < AdminController
  def index
    @users = User.where(:role => 'user')
  end

end
