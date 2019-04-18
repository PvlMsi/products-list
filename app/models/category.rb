class Category < ApplicationRecord
  has_ancestry
  has_many :categories_parameters
  has_many :parameters, through: :categories_parameters
  has_many :products, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :parent_id, presence: true

  accepts_nested_attributes_for :parameters
  accepts_nested_attributes_for :categories_parameters

  before_create :check_parameters
  before_update :clear_parameters

  scope :without_parameters, -> { order(name: :asc).reject { |c| c.parameters.any? } }
  scope :all_but_current, ->(category) { where.not(id: category) }
  scope :except_root, -> { where.not(name: 'Root') }
  scope :childless, -> { select(&:has_children?) }

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

  def clear_parameters
    changed_parameters =
      parameters.select{ |p| p.changed? && !p.new_record? }.map do |parameter|
        parameters.delete(parameter)
        next Parameter.where(
          name: parameter.name,
          data_type: parameter.data_type
        ).first_or_create
        parameter.reload
      end
    parameters << changed_parameters
  end

  def check_parameters
    existing_params = []
    new_params = parameters
    parameters.each do |param|
      param.options.reject!(&:blank?)

      existing_parameter = Parameter.where(
        name: param.name.capitalize,
        data_type: param.data_type,
        options: param.options
      ).first
      if existing_parameter
        existing_params << existing_parameter
        new_params.delete(param)
      end
    end

    self.parameters = existing_params + new_params
  end
end
