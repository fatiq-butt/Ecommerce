class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :set_states, :set_cities, only: [:index]  

  def index
    @line_items = current_user.cart.line_items
    @coupon = Coupon.find_by name: params[:coupon_code]
    @total_price = current_user.cart.calculate_total_price(@coupon)

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create_order
    @coupon = Coupon.find_by name: params[:coupon_code]
    @total_price = current_user.cart.calculate_total_price(@coupon)
    @disconted_price = current_user.cart.calculate_total_price(@coupon)
    Order.create_order(current_user, @total_price, @disconted_price, @coupon)
  end

  def confirmation
    current_user.orders.last.confrimed_order()
  end

  private

  def set_states
    if params[:country] && params[:state].nil?
      @states = CS.states(params[:country])
    end
  end

  def set_cities
    if params[:state]
      @cities = CS.cities(params[:state], params[:country])
    end
  end
end
