class Order < ApplicationRecord
  has_many :products, through: :receipt
  belongs_to :user
end
