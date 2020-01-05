class Api::V1::UsersController < ApplicationController

  # skip_before_action :authenticate!, only: [:register, :login, :user_data, :forgot_password, :reset_password, :invitation, :unlock, :resend_unlock, :user_referral, :check_invitation_token]
	skip_before_action :verify_authenticity_token  


  # http://localhost:3000/api/v1/register
  # Input Json Body - {"user": {"email": "user1@gmail.com", "password": "password1"}}
  def register
	  user = User.new(user_params)
    if user.save
      render json: {status: 200, authentication_token: user.authentication_token}
    else
      error_response(user.errors.full_messages.to_a)
    end
  end

  # http://localhost:3000/api/v1/login
  def login
  	product_id = $product_id
    email = params[:email]
    password = params[:password]
    if email.nil?
      error_response("Enter email.")
      return
    end
    user = User.where(email: email).first
    if user.nil?
      error_response("Invalid email or password.")
      return
    end
    if user.authentication_token.nil? 
      user.save!
    end
    if user.valid_password?(password)
      render json: {status: 200, authentication_token: user.authentication_token}
      return 
    else
    	error_response("Invalid email or password.")
    end
  end

  private.

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
