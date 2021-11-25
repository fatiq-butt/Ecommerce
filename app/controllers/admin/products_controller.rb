class Admin::ProductsController < AdminController
  before_action :find_product, only: %i[ show edit update destroy ]
  
  def index
    products = Product.all
    products = products.global_product_search(params[:search]) if params[:search].present?
    products = products.order(params[:sort] => params[:order]) if params[:order].present?
    @pagy, @products = pagy(products, items: 5)

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data CsvGenerationService.new('Product').call, filename: "products-#{Date.today}.csv" }
    end
  end
  
  def new
    @product = Product.new        
  end  

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "New Product Added Successfully."
    else
      render 'new'
    end  
  end

  def show; end

  def edit; end

  def destroy
    @product.destroy

    respond_to do |format|
      format.js
    end
  end

  def update
    if @product.update(product_params)
      flash[:notice] = "Product Updated Successfully.."
      redirect_to admin_products_path
    else
      render 'edit'
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :description, :status, images: [])
  end
end
