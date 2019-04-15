root = Category.new(name: 'Root')
root.save(validate: false)
motoryzacja = Category.create(name: 'Motoryzacja', parent: root)
telefony = Category.create(name: 'Telefony', parent: root)
apple = Category.create(name: 'Apple', parent: telefony)

opel = Category.create(name: 'Opel', parent: motoryzacja)
opel_parameters = [
  { name: 'Rocznik', data_type: :integer },
  { name: 'Przebieg', data_type: :integer },
  { name: 'Cena', data_type: :integer },
  { name: 'Benzyna/diesel', data_type: :array, options: %w[benzyna diesel] }
]
opel_parameters.each do |parameter|
  opel.parameters << Parameter.where(parameter).first_or_create
end

opel_products = [
  {
    name: 'Opel Astra', product_values_attributes: [
      { parameter: Parameter.find_by_name('Rocznik'), value: '2005' },
      { parameter: Parameter.find_by_name('Przebieg'), value: '130000' },
      { parameter: Parameter.find_by_name('Cena'), value: '7000' },
      { parameter: Parameter.find_by_name('Benzyna/diesel'), value: 'diesel' }
    ]
  },
  {
    name: 'Opel Insignia', product_values_attributes: [
      { parameter: Parameter.find_by_name('Rocznik'), value: '2009' },
      { parameter: Parameter.find_by_name('Przebieg'), value: '110000' },
      { parameter: Parameter.find_by_name('Cena'), value: '12000' },
      { parameter: Parameter.find_by_name('Benzyna/diesel'), value: 'diesel' }
    ]
  }
]
opel.products.create(opel_products)

tesla = Category.create(name: 'Tesla', parent: motoryzacja)
tesla_parameters = [
  { name: 'Rocznik', data_type: :integer },
  { name: 'Przebieg', data_type: :integer },
  { name: 'Cena', data_type: :integer }
]

tesla_parameters.each do |parameter|
  tesla.parameters << Parameter.where(parameter).first_or_create
end

tesla_products = [
  {
    name: 'Tesla Model 3', product_values_attributes: [
      { parameter: Parameter.find_by_name('Rocznik'), value: '2018' },
      { parameter: Parameter.find_by_name('Przebieg'), value: '30000' },
      { parameter: Parameter.find_by_name('Cena'), value: '400000' }
    ]
  },
  {
    name: 'Tesla Model X', product_values_attributes: [
      { parameter: Parameter.find_by_name('Rocznik'), value: '2017' },
      { parameter: Parameter.find_by_name('Przebieg'), value: '80000' },
      { parameter: Parameter.find_by_name('Cena'), value: '300000' }
    ]
  }
]
tesla.products.create(tesla_products)

iphone = Category.create(name: 'iPhone', parent: apple)
iphone_parameters = [
  { name: 'Wersja', data_type: :string },
  { name: 'System', data_type: :string },
  { name: 'Cena', data_type: :integer }
]

iphone_parameters.each do |parameter|
  iphone.parameters << Parameter.where(parameter).first_or_create
end

iphone_products = [
  {
    name: 'iPhone Xs 128 GB', product_values_attributes: [
      { parameter: Parameter.find_by_name('Wersja'), value: 'Xs' },
      { parameter: Parameter.find_by_name('System'), value: 'iOS 12' },
      { parameter: Parameter.find_by_name('Cena'), value: '6000' }
    ]
  },
  {
    name: 'iPhone 6 32GB', product_values_attributes: [
      { parameter: Parameter.find_by_name('Wersja'), value: '6' },
      { parameter: Parameter.find_by_name('System'), value: 'iOS 10' },
      { parameter: Parameter.find_by_name('Cena'), value: '3000' }
    ]
  }
]
iphone.products.create(iphone_products)
