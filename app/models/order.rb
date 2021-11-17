class Order < ApplicationRecord
  has_many :receipts, dependent: :destroy
  has_many :products, through: :receipts
  belongs_to :user
  belongs_to :coupon

  private

  def self.create_order(user)
    order = user.orders.create
    user.cart.line_items.each do |line_item|
      order.receipts.create(product: line_item.product, quantity: line_item.quantity)
      line_item.destroy
    end
  end
end
