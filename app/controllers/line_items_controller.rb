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

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html {redirect_to checkout_index_path}
      format.js
    end
  end

  def add_quantity 
    @row_index = params[:row_index]
    @line_item = LineItem.find(params[:id])
    @line_item.quantity += 1
    @line_item.save
    @line_items = @line_item.cart.line_items
    respond_to do |format|
      format.js
    end 
  end

  def reduce_quantity
    @row_index = params[:row_index]
    @line_item = LineItem.find(params[:id])
    @line_items = @line_item.cart.line_items
    if @line_item.quantity > 1
      @line_item.quantity -= 1
    end
    @line_item.save
    respond_to do |format|
      format.js
    end 
  end
end
