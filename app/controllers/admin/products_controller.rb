class Admin::ProductsController < AdminController
  def index;end
  
  def new
    @product = Product.new        
  end  

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path
    else
      render 'new'
    end  
  end

  private

  def product_params
    params.require(:product).permit(:title, :price, :description, :status)
  end
end
