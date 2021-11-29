class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items, dependent: :destroy

  def calculate_total_price(coupon)
    @sum = 0
    if coupon
      @sum = line_items.collect { |line_item| line_item.product.coupons.include?(coupon)? line_item_discounted_price(line_item, coupon.discount) : line_item_total_price(line_item) }.sum
    else
      @sum = line_items.collect { |line_item| line_item_total_price(line_item) }.sum
    end
    @sum.round(3)
  end

  def line_items_details(coupon)
    self.line_items.map do |line_item|
      if line_item.product.coupons.include?(coupon)
        {name: line_item.product.title, amount: ((line_item.product.price - (line_item.product.price * (coupon.discount/100)))*100).to_i, currency: "usd", quantity: line_item.quantity}
      else
        {name:line_item.product.title, amount: (line_item.product.price*100).to_i, currency: "usd", quantity: line_item.quantity}
      end
    end
  end

  private

  def line_item_discounted_price(line_item, discount_per)
    (line_item.product.price*line_item.quantity)-((line_item.product.price*line_item.quantity)*discount_per/100)
  end

  def line_item_total_price(line_item)
    line_item.product.price*line_item.quantity
  end
end
