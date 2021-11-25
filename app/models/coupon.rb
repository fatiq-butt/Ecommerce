class Coupon < ApplicationRecord
  include PgSearch::Model

  has_and_belongs_to_many :products

  validates :name, presence: true
  validates :discount, numericality: true, presence: true

  pg_search_scope :global_coupon_search, against: [:id, :name, :discount], using: { tsearch: { prefix: true } }

  private

  def self.csv_attributes
    [:id, :name, :discount]
  end
end
