class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :set_states, :set_cities, only: [:index]  
  after_action :place_order, only: [:create]
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
    byebug
    @session = Stripe::Checkout::Session.create({
        payment_method_types: ['card'],
        line_items: @line_items,
        mode: 'payment',
        success_url: "http://localhost:3000/",
        cancel_url: "http://localhost:3000/",
      })
    respond_to do |format|
      format.js
    end
  end

  def confirmation
    if params[:payment_method] != "card"
      current_user.orders.last.confrimed_order()
    end
  end

  private

  def place_order
    byebug
    current_user.orders.last.confrimed_order()
    redirect_to root_path
  end

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
