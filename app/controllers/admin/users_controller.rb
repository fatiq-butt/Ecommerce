class Admin::UsersController < AdminController
  before_action :authenticate_user!
  before_action :find_user, only: %i[show edit update destroy]

  def index
    users = User.user
    users = users.global_search(params[:search]) if params[:search].present?
    @pagy, @users = pagy(users, items: 5)

    respond_to do |format|
      format.html
      format.csv { send_data CsvGenerationService.new('User').call, filename: "users-#{Date.today}.csv" }
    end
  end

  def show; end

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
