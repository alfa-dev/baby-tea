class ProductsController < ApplicationController

	def index
		@products = Product.all
	end

	def new
		@product = Product.new 
	end

	def edit
		find_product 
	end

	def show
		find_product
	end

	def create
		@product = Product.new product_params

	    if @product.save
	     	redirect_to product_path(@product), notice: 'Produto foi criado com sucesso'
	    else
	    	redirect_to :back, notice: @product.errors
	    end
	end

	def update
		@product = Product.new product_params

	    if @product.save
	      redirect_to product_path(@product), notice: 'Produto foi criado com sucesso'
	    end
	end

	def destroy
		find_product

		if @product.destroy
			redirect_to products_path, notice: "#{@product.name} deletado com sucesso"
		else
			redirect_to :back, notice: @product.errors
		end
	end


	private

	def find_product
		@product = Product.find params[:id]
	end

	def product_params
		params.require(:product).permit(:name, :image, :url, :category)
	end

end
