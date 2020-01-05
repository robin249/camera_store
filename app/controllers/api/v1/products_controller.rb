class Api::V1::ProductsController < ApplicationController
	skip_before_action :verify_authenticity_token 

  # http://localhost:3000/api/v1/products
  def index
	  products = Product.all

    if products.any?
      render json: products
    else
      error_response('No record found!')
    end
  end

  # http://localhost:3000/api/v1/create_product
  # Input Json Body - {"product": {"name": "Nikon D850", "category_id": "1", "description": "Nikon D850 summary", "price": "11000", "make": "2012"}}
  def create
	  product = Product.new(product_params)
    if product.save
      render json: {status: 200, message: 'Product has been created successfully!'}
    else
      error_response(product.errors.full_messages.to_a)
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :category_id, :description, :price, :make)
  end
end
