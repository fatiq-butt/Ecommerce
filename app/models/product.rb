class Product < ApplicationRecord
  has_many_attached :images  

  STATUS = ["Publish", "Draft", "Pending"]
  
  validates :price, numericality: {only_integer: false}, presence: true 
  validates :title, :description, :status, presence: true 

end
