class Category < ApplicationRecord
	validates :name, presence: true
	validates :category_type, presence: true
	validates :model, presence: true

  enum category_type: [ :Mirrorless, :'full frame', :'point and shoot']

  has_many :products

end
