class Admin::ProductsController < ApplicationController

	before_action :check_admin

	def index
		@products_diaper = Product.all.diaper.include_disabled.order(:name, :id).group_by(&:name)
		@products_low 	 = Product.all.low.include_disabled.order(:name, :id).group_by(&:name)
		@products_med 	 = Product.all.med.include_disabled.order(:name, :id).group_by(&:name)
		@products_high 	 = Product.all.high.include_disabled.order(:name, :id).group_by(&:name)
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
		quantity = params[:quantity].to_i > 1 ? params[:quantity].to_i : 1

		quantity.times do |i|

			@product = Product.new product_params

		    if @product.save
		     	redirect_to admin_product_path(@product), notice: 'Produto foi criado com sucesso' unless quantity > 1
		    else
		    	redirect_to :back, notice: @product.errors
		    end
		end

		if quantity > 1
			redirect_to admin_products_path, notice: "#{quantity} produtos foram criados com sucesso"
		end
	end

	def update
		find_product

		Product.include_disabled.where(name: @product.name).update(product_params)

	    if @product.save
	      redirect_to admin_products_path(anchor: "product_#{@product.id}"), notice: 'Produto foi atualizado com sucesso'
	    end
	end

	def destroy
		find_product

		if Product.where(name: @product.name).destroy_all
			redirect_to admin_products_path, notice: "#{@product.name} deletado com sucesso"
		else
			redirect_to :back, notice: @product.errors
		end
	end


	private

	def find_product
		@product = Product.include_disabled.find params[:id]
	end

	def product_params
		params.require(:product).permit(:name, :image, :url, :category, :brand, :enabled)
	end

	def check_admin
		redirect_to user_path(current_user) unless current_user.is_admin?
	end

end
