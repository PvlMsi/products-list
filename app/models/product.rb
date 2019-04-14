class Product < ApplicationRecord
  belongs_to :category
  has_many :product_values
  has_many :parameters, through: :product_values

  accepts_nested_attributes_for :product_values

  def self.search(filters)
    return all unless filters

    results = []
    filters.each do |filter|
      if filter[:value].present?
        results << Product.joins(:product_values).merge(
          ProductValue.where(
            parameter_id: filter[:parameter_id],
            value: filter[:value]
          )
        )
      end
      if filter[:value_from].present?
        results << Product.joins(:product_values).merge(
          ProductValue.where(parameter_id: filter[:parameter_id]).where(
            'CAST(value AS INT) >= ?', filter[:value_from].to_i
          )
        )
      end
      if filter[:value_to].present?
        results << Product.joins(:product_values).merge(
          ProductValue.where(parameter_id: filter[:parameter_id]).where(
            'CAST(value AS INT) <= ?', filter[:value_to].to_i
          )
        )
      end
    end
    results.empty? ? all : results.inject { |sum, result| sum & result }
  end
end
