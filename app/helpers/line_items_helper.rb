module LineItemsHelper
  def line_item_price_calculate(quantity,price,line_item)
    @coupon = Coupon.find_by name: params[:coupon_code]
    if line_item.product.coupons.include?(@coupon)
      @discount_price = (@coupon.discount/100) * (quantity*price)
      (quantity*price) - @discount_price
    else
      quantity*price
    end  
  end
end
