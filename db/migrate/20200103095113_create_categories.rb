class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, index: true, null: false
      t.integer :category_type, index: true, default: 0, null: false
      t.integer :model, null: false

      t.timestamps
    end
  end
end
