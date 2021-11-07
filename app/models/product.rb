require 'csv'
class Product < ApplicationRecord
  include PgSearch::Model

  has_many_attached :images 

  STATUS = ["Publish", "Draft", "Pending"]

  pg_search_scope :global_product_search, against: [:id, :title, :price, :description, :status], using: {tsearch: {prefix: true}}
  
  validates :price, numericality: {only_integer: false}, presence: true 
  validates :title, :description, :status, :images, presence: true 

  def self.to_csv
    attributes = %w{id title price description status}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end
end
