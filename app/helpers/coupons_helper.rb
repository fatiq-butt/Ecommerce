module CouponsHelper
  def coupons_drop_down
    Coupon.all.map{|cat| [cat.name,cat.id]}
  end
end
