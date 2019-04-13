class CreateProductValues < ActiveRecord::Migration[5.2]
  def change
    create_table :product_values do |t|
      t.references :product, foreign_key: true
      t.references :parameter, foreign_key: true
      t.string :value

      t.timestamps
    end
  end
end
