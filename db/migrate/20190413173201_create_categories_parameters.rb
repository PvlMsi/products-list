class CreateCategoriesParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_parameters do |t|
      t.belongs_to :category, index: true
      t.belongs_to :parameter, index: true
    end
  end
end
