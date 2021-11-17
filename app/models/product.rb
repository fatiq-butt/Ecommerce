require 'csv'
class Product < ApplicationRecord
  has_and_belongs_to_many :coupons
  has_many_attached :images, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :receipts
  has_many :orders, through: :receipts
  belongs_to :category

  include PgSearch::Model

  STATUS = ["Publish", "Draft", "Pending"]

  pg_search_scope :global_product_search, against: [:id, :title, :price, :description, :status], using: {tsearch: {prefix: true}}
  
  validates :price, numericality: {only_integer: false}, presence: true 
  validates :title, :description, :status, :images, presence: true 

  private
  
  def self.generate_csv
    CsvFormat.to_csv(self,"id", "title", "price", "description", "status")
  end
end
