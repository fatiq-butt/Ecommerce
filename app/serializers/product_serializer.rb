class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :price, :description, :status, :category
end
