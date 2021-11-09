module CouponsHelper
  def coupons_drop_down
    Product.all.map{|cat| [cat.title,cat.id]}
  end
end
