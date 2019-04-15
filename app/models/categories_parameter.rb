class CategoriesParameter < ApplicationRecord
  belongs_to :category
  belongs_to :parameter

  accepts_nested_attributes_for :category, reject_if: :all_blank
end
