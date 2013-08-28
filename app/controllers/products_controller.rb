# encoding: utf-8
class ProductsController < ApplicationController

	before_filter :load

	def load
		@products = Product.paginate(page: params[:page], per_page: 15)
		@product = Product.new
	end

	def index
	end

	def new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/subjects/js/new" }
		end
	end

	def create
		@product = Product.new(params[:product])
		create_item @product, @products
	end

	def edit
		@product = Product.find(params[:id])
		respond_to do |format|
			format.html { redirect_to products_path }
			format.js {render partial: "shared/subjects/js/edit", locals:{item: @product}}
		end
	end
	def update
		@product = Product.find(params[:id])
		update_item @product, @products
	end
end