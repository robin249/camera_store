class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name, index: true
      t.references :category, index: true, foreign_key: true
      t.text :description
      t.decimal :price, precision: 12, scale: 2
      t.integer :make

      t.timestamps
    end
  end
end
