class Cart < ApplicationRecord
  belongs_to :user
  has_many :line_items

  private 

  def self.calculate_total_price(line_items)
    line_items.collect {|line_item| line_item.product.price*line_item.quantity}.sum
  end
end
