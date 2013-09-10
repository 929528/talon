# encoding: utf-8
class ProductsController < ApplicationController

	before_filter :load, except: :edit

	def load
		if (defined? params[:filter]) && !(params[:filter].blank?)
			@products = Product.where("name = ?", params[:filter])
		else
			@products = Product.paginate(page: params[:page], per_page: 9)
		end
		@product = Product.new
	end

	def index
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_filter", locals: {items: @products} }
		end
	end

	def new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		product = Product.new(product_params)
		if product.valid? && product.save
			flash.now[:notice] = "Номенклатура #{product.fullname} успешно добавлена"
			respond_to do |format|
				format.html { redirect_to products_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: product, items: @products}}
			end
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, номенклатура #{product.fullname} не сохранена"
			respond_to do |format|
				format.html { redirect_to products_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: product, items: @products}}
			end
		end
	end

	def edit
		@product = Product.find(params[:id])
		respond_to do |format|
			format.html { redirect_to products_path }
			format.js {render partial: "shared/js/item_edit", locals:{item: @product}}
		end
	end
	def update
		product = Product.find(params[:id])
		if product.valid? && product.update_attributes(product_params)
			flash.now[:notice] = "Номенклатура: #{product.fullname} успешно обновлена"
			respond_to do |format|
				format.html { redirect_to products_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: product, items: @products}} 
			end
		else
			flash.now[:error] = "Произошла ошибка при обновлении номенклатуры: #{product.fullname} не обновлена"
			respond_to do |format|
				format.html { redirect_to products_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: product, items: @products}}
			end
		end
	end

	private

	def product_params
		params.require(:product).permit(:name, :fullname, :idsymbol)
	end
end