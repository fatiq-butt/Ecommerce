module LineItemsHelper
  def line_item_price_calculate(quantity,price,line_item)
    @coupon = Coupon.find_by name: params[:coupon_code]
    total = 0
    if line_item.product.coupons.include?(@coupon)
      @discount_price = (@coupon.discount/100) * (quantity*price)
      total = (quantity*price) - @discount_price
    else
      total = quantity*price
    end
    "$#{total.round(3).to_s}"
  end
end
