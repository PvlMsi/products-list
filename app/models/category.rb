class Category < ApplicationRecord
  has_ancestry
  has_many :categories_parameters
  has_many :parameters, through: :categories_parameters
  has_many :products

  validates :name, presence: true
  validates :parent_id, presence: true

  accepts_nested_attributes_for :parameters
  accepts_nested_attributes_for :categories_parameters

  before_create :check_parameters

  scope :with_children, -> { order(name: :asc).select(&:has_children?) }

  def filters
    return parameters if childless?

    subtree.select(&:childless?).map(&:parameters)
           .inject { |sum, parameters| sum & parameters }
  end

  def all_products
    return products if childless?

    Product.where(id: subtree.select(&:childless?).map(&:products).flatten)
  end

  private

  def check_parameters
    params = []
    parameters.each do |param|
      param.options.reject!(&:blank?)

      existing_parameter = Parameter.where(
        name: param.name.capitalize,
        data_type: param.data_type,
        options: param.options
      ).first
      params << existing_parameter ? existing_parameter : param
    end

    self.parameters = params
  end
end
