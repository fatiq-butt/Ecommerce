module CouponsHelper
  def coupon_options
    Product.all.map { |cat| [cat.title, cat.id] }
  end
end
