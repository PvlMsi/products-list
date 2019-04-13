class Category < ApplicationRecord
  has_ancestry
  has_and_belongs_to_many :parameters
  has_many :products
end
