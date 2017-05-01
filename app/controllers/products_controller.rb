class ProductsController < ApplicationController

	def index
		@products_low 		= Product.all.where(user: nil, category: :low).group_by &:name
		@products_med 		= Product.all.where(user: nil, category: :med).group_by &:name
		@products_high 		= Product.all.where(user: nil, category: :high).group_by &:name
		@products_diaper 	= Product.all.where(user: nil, category: :diaper).group_by &:name
	end

	def edit
		find_product

		@product.user = current_user

		if @product.save
		    redirect_to user_path(current_user), notice: 'Produto foi selecionado com sucesso'
		else
		    redirect_to :back, notice: @product.errors
		end
	end

	def show
		find_product
	end

	def destroy
		find_product

		@product.update(user: nil)
		redirect_to user_path(current_user)
	end

	private

	def find_product
		@product = Product.find params[:id]
	end

	def product_params
		params.require(:product).permit(:name, :image, :url, :category)
	end

end
