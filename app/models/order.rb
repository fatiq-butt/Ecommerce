class Order < ApplicationRecord
  has_many :receipts, dependent: :destroy
  has_many :products, through: :receipts
  belongs_to :user
  belongs_to :coupon, optional: true

  def self.create_order(user, total_price, discounted_price, coupon)
    unless user.orders.where(confirmed: false).any?
      order = user.orders.create(total_price: total_price, discounted_total: discounted_price, coupon: coupon)
    end
  end

  def confrimed_order
    user.cart.line_items.each do |line_item|
      self.receipts.create(product: line_item.product, quantity: line_item.quantity)
      line_item.destroy
    self.update(confirmed: true)
    end
  end
end
