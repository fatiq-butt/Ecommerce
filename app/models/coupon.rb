require 'csv'
class Coupon < ApplicationRecord
  has_and_belongs_to_many :products

  include PgSearch::Model

  validates :name, presence: true
  validates :discount, numericality: {only_integer: false}, presence: true  

  pg_search_scope :global_coupon_search, against: [:id, :name, :discount], using: {tsearch: {prefix: true}}

  private

  def self.generate_csv
    CsvFormat.to_csv(self,"id", "name", "discount")
  end
end
