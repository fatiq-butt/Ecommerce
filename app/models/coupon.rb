class Coupon < ApplicationRecord
  has_and_belongs_to_many :products

  validates :name, presence: true
  validates :discount, numericality: {only_integer: false}, presence: true  
end
