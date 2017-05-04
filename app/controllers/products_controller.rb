class ProductsController < ApplicationController

	def index
		if(params[:category].nil?)
			@products_low 		= Product.all.where(user: nil, category: :low).group_by &:name
			@products_med 		= Product.all.where(user: nil, category: :med).group_by &:name
			@products_high 		= Product.all.where(user: nil, category: :high).group_by &:name
			@products_diaper 	= Product.all.where(user: nil, category: :diaper).order(:updated_at).group_by &:name
		else
			@category = params[:category];
			@products = Product.all.where(user: nil, category: params[:category]).group_by &:name
		end
	end

	def edit
		find_product

		@product.user = current_user

		notice = "<p class='gift-modal'>Você selecionou a o presente
					<span class='gift'>#{@product.name}</span>
					<img src='#{@product.image}' alt=''>
					<span class='thanks'>Muito obrigado!</span>
					<a href='#close'>ok!</a>
				  </p>"
		notice = "<p class='diaper-modal'>
				  	Você selecionou a fralda
				  	<span class='gift'>#{@product.name}</span>
					<img src='#{@product.image}' alt=''>
				  	<span class='thanks'>Muito obrigado!</span>
				  	<a href='#close'>ok!</a>
				  </p>" if @product.category == "diaper"

		if @product.save
		    redirect_to user_path(current_user), notice: notice
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
		params.require(:product).permit(:name, :image, :url, :category, :brand)
	end

end
