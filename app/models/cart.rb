class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  def calculate_total_price(coupon)
    @sum = 0
    if coupon
      @discount_price = coupon.discount/100
      @sum = line_items.collect {|line_item| line_item.product.coupons.include?(coupon)? (line_item.product.price*line_item.quantity)-((line_item.product.price*line_item.quantity)*@discount_price) : line_item.product.price*line_item.quantity }.sum
    else
      @sum = line_items.collect {|line_item| line_item.product.price*line_item.quantity}.sum
    end
    @sum
  end

  def line_items_details(coupon)
    check = true

    @discount_price = coupon.discount/100
    self.line_items.map do |line_item|
      if line_item.product.coupons.include?(coupon) && check
        check = false
        {name: line_item.product.title, amount: ((line_item.product.price - (line_item.product.price * @discount_price))*100).to_i, currency: "usd", quantity: line_item.quantity}
      else
        {name:line_item.product.title, amount: (line_item.product.price*100).to_i, currency: "usd", quantity: line_item.quantity}
      end
    end
  end
end
