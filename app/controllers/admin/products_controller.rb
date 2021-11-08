class Admin::ProductsController < AdminController
  before_action :set_product, only: %i[ show edit update destroy ]
  
  def index
    if params[:order].present?
        @pagy, @products = pagy(Product.all.order(params[:sort] => params[:order]), items: 5)
    elsif params[:search].present?
        @pagy, @products = pagy(Product.all.global_product_search(params[:search]), items: 5)
    else
      @pagy, @products = pagy(Product.all, items: 5)
    end

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Product.generate_csv, filename: "products-#{Date.today}.csv" }
    end
  end
  
  def new
    @product = Product.new        
  end  

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: "New Product Added Successfully.."
    else
      render 'new'
    end  
  end

  def show;end

  def edit;end

  def destroy
    respond_to do |format|
      @product.destroy
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

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :price, :description, :status, images: [])
  end
end
