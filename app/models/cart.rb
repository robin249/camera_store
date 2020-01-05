class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  enum status: [ :active, :placed, :processing, :shipped, :canceled, :completed]
end
