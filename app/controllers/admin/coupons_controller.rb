class Admin::CouponsController < AdminController
  before_action :set_coupon, only: %i[ show edit update destroy ]

  def index
    @coupons = Coupon.all
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

  def destroy
    respond_to do |format|
      @coupon.destroy
      format.js
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
