class Admin::CouponsController < AdminController
  before_action :set_coupon, only: %i[ show edit update destroy ]

  def index
    if params[:order].present?
        @pagy, @coupons = pagy(Coupon.all.order(params[:sort] => params[:order]), items: 5)
    elsif params[:search].present?
        @pagy, @coupons = pagy(Coupon.all.global_coupon_search(params[:search]), items: 5)
    else
      @pagy, @coupons = pagy(Coupon.all, items: 5)
    end

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Coupon.generate_csv, filename: "coupons-#{Date.today}.csv" }
    end
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to admin_coupons_path, notice: "New Coupon Added Successfully.."
    else
      render 'new'
    end  
  end

  def show;end

  def edit;end

  def destroy
    respond_to do |format|
      @coupon.destroy
      format.js
    end    
  end

  def update
    if @coupon.update(coupon_params)
      flash[:notice] = "Coupon Updated Successfully.."
      redirect_to admin_coupons_path
    else
      render 'edit'
    end
  end

  private

  def set_coupon
    @coupon = Coupon.find(params[:id])
  end

  def coupon_params
    params.require(:coupon).permit(:name,:discount,product_ids: [])
  end
end
