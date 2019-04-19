class Product < ApplicationRecord
  belongs_to :category
  has_many :product_values, dependent: :destroy
  has_many :parameters, through: :product_values

  accepts_nested_attributes_for :product_values

  paginates_per 10

  validates :name, presence: true
  validates :category, presence: true

  def self.search(filters)
    return all unless filters

    results = []
    filters.each do |filter|
      query = SearchQuery.new(filter, all)
      results << query.value_equal if filter[:value].present?
      results << query.value_more_than if filter[:value_from].present?
      results << query.value_less_than if filter[:value_to].present?
    end

    results.empty? ? all : results.inject { |sum, result| sum & result }
  end
end
