class ProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    @products = Product.where(status: "Publish")
  end
end
