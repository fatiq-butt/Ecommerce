class CheckoutController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @line_items = current_user.cart.line_items
    @total_price = Cart.calculate_total_price(@line_items)
    if params[:country]
      @states = CS.states(params[:country])
    end
    if params[:state]
      @cities = CS.cities(params[:state],params[:country])
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
end
