class Product < ApplicationRecord
	has_many :order_items

	# All we did here is add a default scope that checks if the active flag is set to true. 
	# This ensures that deleted/inactive products aren't shown.

	default_scope { where(active: true)}
end
