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

  def create
    @line_items = current_user.cart.line_items_details(current_user.orders.last.coupon)
    @order = current_user.orders.last
    result = PlaceOrder.call(payment_method: params[:payment_method], items: @line_items, order: @order, cart_line_items: current_user.cart.line_items)

    if result.success?
      @session = result.session
      flash[:notice] = "Your order Placed Successfully."
    else
      flash[:error] = result.message
    end
    respond_to do |format|
      format.js
    end
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
