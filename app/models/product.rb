class Product < ApplicationRecord
  include PgSearch::Model

  has_and_belongs_to_many :coupons
  has_many_attached :images, dependent: :destroy
  belongs_to :category

  pg_search_scope :global_search, against: [:id, :title, :price, :description, :status], using: { tsearch: { prefix: true } }

  STATUSES = ["Publish", "Draft", "Pending"].freeze

  validates :price, numericality: true, presence: true
  validates :title, :description, :status, :images, presence: true 

  def self.csv_attributes
    [:id, :title, :price, :status]
  end
end
