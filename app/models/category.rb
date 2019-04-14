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

    Product.where(id: subtree.select(&:childless?).map(&:products).flatten)
  end
end
