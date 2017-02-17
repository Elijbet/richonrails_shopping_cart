class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  #The first validation for quantity ensures that the quantity is a number that is an integer and is greater than 0. 
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0}
  validate :product_present
  validate :order_present

  before_save :finalize

 
 # The unit_price function will take the associated product's price if the order item is not currently persisted.
 # If the order item is persisted then the contents of the unit_price field will be returned instead. Before the model
 # is saved, the return value of unit_price is written to the unit_price field. This means that once the product is 
 # added to our cart, if the product changes price the user will still be able to buy the product at the previous 
 # price. This is necessary because if the price changes while the user is in checkout, there could be a mismatch 
 # between the product price on the cart page and the product price on the checkout page. 
  

  def unit_price
  	if persisted?
  		self[:unit_price]
  	else 
  		product.unit_price
 		end
  end

  	def total_price
  		unit_price * quantity
  		end

  		private

  		def product_present
  			if product.nil?
  				errors.add(:product, "is not valid or is not active.")
  			end
  		end

  		def order_present
  			if order.nil?
  				errors.add(:order, "is not a valid order.")
  			end
  		end

  		def finalize
  			self[:unit_price] = unit_price
  			self[:total_price] = quantity * self[:unit_price]
  		end


end
