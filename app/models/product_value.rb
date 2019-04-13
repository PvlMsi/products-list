class ProductValue < ApplicationRecord
  belongs_to :product
  belongs_to :parameter
end
