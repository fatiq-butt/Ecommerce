class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items

  def calculate_total_price(coupon)
    @coupon = Coupon.find_by name: coupon
    if @coupon
      @discount_price = @coupon.discount/100
      @sum = line_items.collect {|line_item| line_item.product.coupons.include?(@coupon)? (line_item.product.price*line_item.quantity)-((line_item.product.price*line_item.quantity)*@discount_price) : line_item.product.price*line_item.quantity }.sum
    else
      @sum = line_items.collect {|line_item| line_item.product.price*line_item.quantity}.sum
    end
  end
end
