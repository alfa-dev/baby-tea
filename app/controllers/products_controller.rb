class ProductsController < ApplicationController

	before_action :check_logged

	def index
		@filter = params[:category].nil?

		if(@filter)
			@products_low 		= Product.all.where(user: nil, category: :low).group_by &:name
			@products_med 		= Product.all.where(user: nil, category: :med).group_by &:name
			@products_high 		= Product.all.where(user: nil, category: :high).group_by &:name

		else
			@category = params[:category];
			@products = Product.all.where(user: nil, category: params[:category]).group_by &:name
		end
	end

	def edit
		find_product

		@product.user = current_user

		if @product.save
			log('add')
		    redirect_to product_path(@product)
		else
		    redirect_to :back, notice: @product.errors
		end
	end

	def show
		find_product
	end

	def destroy
		find_product
		log('remove')

		@product.update(user: nil)
		redirect_to user_path(current_user)
	end

	private

	def find_product
		@product = Product.find params[:id]
	end

	def product_params
		params.require(:product).permit(:name, :image, :url, :category, :brand)
	end

	def log action
		user_log = Log.new(user_id: current_user.id, product_id: @product.id, action: action )
		user_log.save
	end
end
