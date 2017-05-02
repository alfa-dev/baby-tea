class UsersController < ApplicationController

	def show
		@user_products 		  = current_user.products.where.not(category: "diaper")
		@user_products_diaper = current_user.products.where(category: "diaper")
	end

end
