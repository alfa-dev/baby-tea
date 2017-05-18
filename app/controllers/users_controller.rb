class UsersController < ApplicationController

	def show
		@user_products 		  = current_user.products.where.not(category: "diaper")
		@user_products_diaper = current_user.products.diaper

		return redirect_to user_how_to_diaper_path(current_user) if @user_products_diaper.count.zero?
		return redirect_to user_how_to_gift_path(current_user) if @user_products.count.zero? && !current_user.gift_offer
	end

	def how_to_diaper
		@products_diaper = Product.diaper.where(user: nil).group_by(&:name).map{ |i| i.second.first }
	end

	def how_to_gift
		current_user.update(gift_offer: true)

		@products = Product.where.not(category: "diaper").group_by(&:category).map{ |i| i.second.first }
	end

end
