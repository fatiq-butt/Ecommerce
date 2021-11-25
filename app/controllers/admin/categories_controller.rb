class Admin::CategoriesController < AdminController
  before_action :find_category, only: %i[ show edit update destroy ]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "New Category Added Successfully."
    else
      render 'new'
    end  
  end

  def show; end

  def edit; end

  def destroy
    @category.destroy

    respond_to do |format|
      format.js
    end    
  end

  def update
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Category Updated Successfully."
    else
      render 'edit'
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
