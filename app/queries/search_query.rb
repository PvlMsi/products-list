class SearchQuery
  def initialize(filter, products)
    @products = products
    @filter = filter
  end
  
  def value_equal
    @products.joins(:product_values).merge(
      ProductValue.where(
        parameter_id: @filter[:parameter_id],
        value: @filter[:value]
      )
    )
  end
  
  def value_more_than
    @products.joins(:product_values).merge(
      ProductValue.where(parameter_id: @filter[:parameter_id]).where(
        'CAST(value AS INT) >= ?', @filter[:value_from].to_i
      )
    )
  end
  
  def value_less_than
    @products.joins(:product_values).merge(
      ProductValue.where(parameter_id: @filter[:parameter_id]).where(
        'CAST(value AS INT) <= ?', @filter[:value_to].to_i
      )
    )
  end
end