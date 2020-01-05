class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  before_save :finalize
  after_save :update_cart_total

  def unit_price
    if persisted?
      self[:price]
    else
      product.price
    end
  end

  private

	def finalize
		self[:price] = unit_price
		self[:total] = quantity * self[:price]
	end

	def update_cart_total
		# Update cart total
		subtotal = cart.cart_items.collect { |ct| ct.valid? ? (ct.total) : 0 }.sum
		total = subtotal + cart.tax - cart.discount
		cart.update_attributes({subtotal: subtotal, total: total})
	end
end
