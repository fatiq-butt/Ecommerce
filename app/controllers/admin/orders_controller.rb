class Admin::OrdersController < AdminController
  before_action :authenticate_user!

  def index
    @orders = Order.all.where(confirmed: true)
  end

end
