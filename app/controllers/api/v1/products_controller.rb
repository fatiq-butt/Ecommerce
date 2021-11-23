class Api::V1::ProductsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :product_params, only: [:create, :update]
  before_action :set_product, only: [:show, :update, :destroy]

  def index
    @products = Product.all
    render json: @products
  end

  def show
    render json: @product
  end

  def create
    @product = Product.create(product_params)
    render json: @product
  end

  def update
    @product.update(product_params)
    render json: @product
  end

  def destroy
    @products = Product.all
    @product.destroy
    render json: @products
  end

  def product_params
    params.permit(:title, :price, :description, :status, :category_id)
  end

  def set_product
    @product = Product.find(params[:id])
  end
end
