class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :set_states, :set_cities, only: [:index]  
  def index  
    @line_items = current_user.cart.line_items
    @total_price = current_user.cart.calculate_total_price(params[:coupon_code])
    
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

  def set_states
    if params[:country]
      @states = CS.states(params[:country])
    end
  end

  def set_cities
    if params[:state]
      @cities = CS.cities(params[:state],params[:country])
    end
  end
end
