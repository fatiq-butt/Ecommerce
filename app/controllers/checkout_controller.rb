class CheckoutController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @line_items = current_user.cart.line_items
    @total_price = Cart.calculate_total_price(@line_items)
  end
  def create
  end
end
