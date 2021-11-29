class Admin::OrdersController < AdminController
  before_action :authenticate_user!

  def index
    @orders = Order.where(confirmed: true)
  end

end
