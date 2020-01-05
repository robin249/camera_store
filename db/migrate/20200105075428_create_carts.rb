class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :subtotal, precision: 12, scale: 2, default: 0
      t.decimal :tax, precision: 12, scale: 2, default: 0
      t.decimal :discount, precision: 12, scale: 2, default: 0
      t.decimal :total, precision: 12, scale: 2, default: 0
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
