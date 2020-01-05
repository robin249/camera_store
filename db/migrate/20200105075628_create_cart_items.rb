class CreateCartItems < ActiveRecord::Migration[5.1]
  def change
    create_table :cart_items do |t|
      t.references :product, index: true, foreign_key: true
      t.references :cart, index: true, foreign_key: true
      t.decimal :price, precision: 12, scale: 2, default: 0
      t.integer :quantity
      t.decimal :total, precision: 12, scale: 2, default: 0

      t.timestamps
    end
  end
end
