class Api::V1::CartsController < ApplicationController
	skip_before_action :verify_authenticity_token 

	# http://localhost:3000/api/v1/cart
  def index

    token = params[:token]
    if token.nil?
      error_response("Token is missing.")
      return
    end

	  cart = current_cart

    if cart.present?
      render json: {cart: cart, cart_items: cart.cart_items}
    else
      error_response('No record found!')
    end
  end

  # http://localhost:3000/api/v1/add_to_cart
  # Input Json Body - {"token":"_DQweKiytmhJY_Z4zVQp", "cart_item": {"product_id": "1", "quantity": "4"}}
  def create
    token = params[:token]
    if token.nil?
      error_response("Token is missing.")
      return
    end
    user = current_user
    if user.nil?
      error_response("User does not exist.")
      return
    end
    product = Product.find_by_id params[:cart_item][:product_id]
    if product.nil?
      error_response("Product does not exist.")
      return
    end

  	cart = current_cart
  	if !cart.present?
      cart = Cart.new(user: user)
      cart.save
    end

    cart_item = cart.cart_items.find_by(product_id: params[:cart_item][:product_id])

    if cart_item
      new_quantity = cart_item.quantity + params[:cart_item][:quantity].to_i
      cart_item.update_attributes({quantity: new_quantity})
    else
    	cart_item = cart.cart_items.new(cart_item_params)
    end

    if cart.save
      render json: {status: 200, message: 'Product has been added into cart!'}
    else
      error_response(cart.errors.full_messages.to_a)
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
