module ProductsHelper
  def currency_price(price)
    "$#{price.to_s}"
  end
end
