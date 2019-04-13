class CreateParameters < ActiveRecord::Migration[5.2]
  def change
    create_table :parameters do |t|
      t.string :name
      t.integer :data_type
      t.string :options, array: true, default: []

      t.timestamps
    end
  end
end
