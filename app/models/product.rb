class Product < ApplicationRecord
  belongs_to :category
  has_many :product_values
  has_many :parameters, through: :product_values

  accepts_nested_attributes_for :product_values
end
