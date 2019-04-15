class Parameter < ApplicationRecord
  enum data_type: %i[integer float boolean string array]

  validates :name, presence: true
  validates :data_type, presence: true, inclusion: { in: data_types.keys }

  before_save :capitalize_name

  private

  def capitalize_name
    name.capitalize!
  end
end
