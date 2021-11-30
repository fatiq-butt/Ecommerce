class CheckoutController < ApplicationController
  include Rails.application.routes.url_helpers

  before_action :authenticate_user!
  before_action :set_states, :set_cities, only: [:index]
  before_action :find_cart
  before_action :create_stripe_session, only: [:create]

  def index
    @line_items = @cart.line_items
    @coupon = Coupon.find_by name: params[:coupon_code]
    @total_price = @cart.calculate_total_price(@coupon)

    respond_to do |format|
      format.js
      format.html
    end
  end

  def create_order
    @coupon = Coupon.find_by name: params[:coupon_code]
    @total_price = @cart.calculate_total_price(@coupon)
    @disconted_price = @cart.calculate_total_price(@coupon)
    Order.create_order(current_user, @total_price, @disconted_price, @coupon)
  end

  def create
    @order = current_user.orders.last
    @order.payment_method = params[:payment_method]
    @order.save
    redirect_to place_order_url unless params[:payment_method] == "card"
    respond_to do |format|
      format.js
    end
  end

  def confirmation
    result = OrderProcessor.call(cart_line_items: @cart.line_items, order: current_user.orders.last)
    redirect_to root_path, notice: "Your order placed successfully."
  end

  private

  def create_stripe_session
    @line_items = @cart.line_items_details(current_user.orders.last.coupon)
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: @line_items,
      mode: 'payment',
      success_url: place_order_url,
      cancel_url: root_url,
    })
  end

  def find_cart
    @cart = current_user.cart
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
