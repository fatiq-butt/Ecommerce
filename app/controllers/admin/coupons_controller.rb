class Admin::CouponsController < AdminController
  include FilterRecords

  before_action :find_coupon, only: %i[ show edit update destroy ]

  def index
    @pagy, @coupons = sort_page_filter(Coupon)

    respond_to do |format|
      format.html
      format.js
      format.csv { send_data CsvGenerationService.new('Coupon').call, filename: "coupons-#{Date.today}.csv" }
    end
  end

  def new
    @coupon = Coupon.new
  end

  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
      redirect_to admin_coupons_path, notice: "New Coupon Added Successfully."
    else
      render 'new'
    end  
  end

  def show; end

  def edit; end

  def destroy
    @coupon.destroy

    respond_to do |format|
      format.js
    end    
  end

  def update
    if @coupon.update(coupon_params)
      redirect_to admin_coupons_path, notice: "Coupon Updated Successfully."
    else
      render 'edit'
    end
  end

  private

  def find_coupon
    @coupon = Coupon.find_by(id: params[:id])
    redirect_to admin_coupons_path unless @coupon
  end

  def coupon_params
    params.require(:coupon).permit(:name,:discount,product_ids: [])
  end
end
