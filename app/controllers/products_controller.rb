class ProductsController < ApplicationController
  def index
  	@products = Product.all
  	# The only thing special about the products controller is it creates a new instance of our OrderItem model 
  	# for use in our forms.
  	@order_item = current_order.order_items.new
  end
end
