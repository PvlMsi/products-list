class Product < ApplicationRecord
  belongs_to :category
  has_many :product_values
  has_many :parameters, through: :product_values

  accepts_nested_attributes_for :product_values

  def self.search(filters)
    return all unless filters

    results = []
    filters.reject { |filter| filter[:value].blank? }.each do |filter|
      results << Product.joins(:product_values).merge(
        ProductValue.where(
          parameter_id: filter[:parameter_id],
          value: filter[:value]
        )
      )
    end
    results.inject { |sum, result| sum & result }
  end
end
