class Catalog::ProductsController < ApplicationController

	def index
		@products = Catalog::Product.paginate(page: params[:page], per_page: 8)
	end

	def new
		@product = Catalog::Product.new
		show_item @product
	end

	def create
		product = Catalog::Product.new(product_params)
		if product.save
			flash.now[:notice] = "Продукт #{product.fullname} создан" 
			perform_after_save product
		else
			flash.now[:notice] = "Произошла ошибка при создании продукта"
			show_errors_on product
		end
	end

	def edit
		@product = Catalog::Product.find(params[:id])
		show_item @product
	end
	def update
		product = Catalog::Product.find(params[:id])
		if product.update_attributes(product_params)
			flash.now[:notice] = "Продукт #{product.fullname} обновлен" 
			perform_after_save product
		else
			flash.now[:notice] = "Произошла ошибка при обновлении продукта"
			show_errors_on product
		end
	end

	def search
		products = Catalog::Product.all
		filter_items(products, params[:filter])
	end

	private

	def product_params
		params.require(:product).permit(:name, :fullname, :symbol)
	end
end