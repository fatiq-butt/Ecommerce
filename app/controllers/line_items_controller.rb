class LineItemsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @chosen_product = Product.find(params[:product_id])
    if current_user.cart.line_items.map(&:product_id).include?(@chosen_product.id)
      @line_item = current_user.cart.line_items.find_by(product_id: @chosen_product)
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = current_user.cart
      @line_item.product = @chosen_product
    end
    @line_item.save
    redirect_to cart_path(current_user.cart)
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.js
    end
  end
end
