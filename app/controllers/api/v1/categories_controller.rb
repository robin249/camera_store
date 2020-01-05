class Api::V1::CategoriesController < ApplicationController
	skip_before_action :verify_authenticity_token 

	# http://localhost:3000/api/v1/categories
  def index
	  categories = Category.all

    if categories.any?
      render json: categories
    else
      error_response('No record found!')
    end
  end

  # http://localhost:3000/api/v1/create_category
  # Input Json Body - {"category": {"name": "Nikon", "category_type": "Mirrorless", "model": "2018"}}
  def create
    category = Category.new(category_params)
    if category.save
      render json: {status: 200, message: 'Category has been created successfully!'}
    else
      error_response(category.errors.full_messages.to_a)
    end
  end

  # http://localhost:3000/api/v1/category/:id
  def show
    category = Category.find_by_id params[:id]

    if category.present?
      render json: category.products
    else
      error_response('No record found!')
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :category_type, :model)
  end
end
