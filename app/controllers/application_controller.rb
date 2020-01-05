class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception



  # Current store order
  helper_method :current_order

  def current_cart
    current_user.current_cart
  end

  def current_user
    user = User.find_by_authentication_token params[:token]
  end

  def failure_response(data, status=400)
    if ![Hash, String].include?(data.class) && data.respond_to?(:errors)
      if data.errors.kind_of?(ActiveModel::Errors)
        data = {:error => data.errors.full_messages.to_a.first.to_s}
      else
        data = {:error => data.errors.first}
      end
    end
    render(:json => data, :status => status)
  end
  
  def error_response(message, status=400)
    failure_response({:error => message, :status => status}, status)
  end
end
