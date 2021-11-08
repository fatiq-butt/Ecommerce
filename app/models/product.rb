require 'csv'
class Product < ApplicationRecord
  belongs_to :category

  include PgSearch::Model

  has_many_attached :images 

  STATUS = ["Publish", "Draft", "Pending"]

  pg_search_scope :global_product_search, against: [:id, :title, :price, :description, :status], using: {tsearch: {prefix: true}}
  
  validates :price, numericality: {only_integer: false}, presence: true 
  validates :title, :description, :status, :images, presence: true 

  private
  
  def self.generate_csv
    CsvFormat.to_csv(self,"id", "title", "price", "description", "status")
  end
end
