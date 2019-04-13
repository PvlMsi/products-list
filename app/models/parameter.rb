class Parameter < ApplicationRecord
  has_and_belongs_to_many :categories
  enum data_type: %i[integer float boolean string array]
end
