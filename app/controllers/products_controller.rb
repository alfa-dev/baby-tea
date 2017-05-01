class ProductsController < ApplicationController

	def index
		@products = Product.all.group_by &:name
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

	private

	def find_product
		@product = Product.find params[:id]
	end

	def product_params
		params.require(:product).permit(:name, :image, :url, :category)
	end

end
