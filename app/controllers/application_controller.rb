class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # The method helper_method is to explicitly share some methods defined in the controller 
  # to make them available for the view.
  helper_method :current_order  

  def current_order
  	if !session[:order_id].nil?
  		Order.find(session[:order_id])
  	else
  		Order.new
  	end
  end
end
