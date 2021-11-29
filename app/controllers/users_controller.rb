class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[ update ]

  def update
    @user.update(user_params)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.permit(:first_name, :last_name, :company_name, :state, :address, :phone, :extension, :city, :zip_code, :country)
  end
end
