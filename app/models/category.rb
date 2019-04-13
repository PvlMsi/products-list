class Category < ApplicationRecord
  has_ancestry
  has_and_belongs_to_many :parameters
  has_many :products

  def filters
    return parameters if childless?

    subtree.select(&:childless?).map(&:parameters)
           .inject { |sum, parameters| sum & parameters }
  end

  def all_products
    return products if childless?

    subtree.select(&:childless?).map(&:products)
           .inject { |sum, product| sum + product }
  end
end
