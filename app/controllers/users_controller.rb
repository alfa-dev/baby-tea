class UsersController < ApplicationController

	def show
		@user_products 		  = current_user.products.where.not(category: "diaper").order(:updated_at)
		@user_products_diaper = current_user.products.where(category: "diaper")
	end

end
