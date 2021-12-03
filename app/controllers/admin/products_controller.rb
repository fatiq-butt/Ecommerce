class Admin::ProductsController < AdminController
  include FilterRecords

  before_action :find_product, only: %i[ show edit update destroy ]
  
  def index
    @pagy, @products = sort_page_filter(Product)
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
    product_destroy
    if @product.destroyed?
      flash[:notice] = "Product is deleted Successfully."
    else
      flash[:notice] = "Can not delete the product, its status is deactivated."
    end
    redirect_to admin_products_path
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: "Product Updated Successfully."
    else
      render 'edit'
    end
  end

  private

  def product_destroy
    if @product.receipts.any?
      @product.deactivated!
    else
      @product.destroy
    end
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    redirect_to admin_products_path unless @product
  end

  def product_params
    params.require(:product).permit(:title, :price, :description, :status, :category_id, images: [])
  end
end
