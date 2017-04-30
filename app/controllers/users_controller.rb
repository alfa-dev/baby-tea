class UsersController < ApplicationController

	def show
		@user_products = current_user.products
	end

end
