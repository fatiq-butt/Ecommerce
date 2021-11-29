class Api::V1::ProductsController < Api::BaseController
  before_action :find_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.create(product_params)
    if @product.persisted?
      render json: @product
    else
      render json: {
        error: @product.errors.messages
      }, status: 400
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: {
        error: @product.errors.messages
      }, status: 400
    end
  end

  def destroy
    @product.destroy
    render json: { alert: "Record deleted" }
  end

  privateg

  def product_params
    params.permit(:title, :price, :description, :status, :category_id)
  end

  def find_product
    @product = Product.find(params[:id])
  end
end
