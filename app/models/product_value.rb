class ProductValue < ApplicationRecord
  belongs_to :product
  belongs_to :parameter

  validates :value, presence: true
  validates :parameter, presence: true
  validates :product, presence: true
end
