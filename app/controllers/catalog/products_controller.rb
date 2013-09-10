# encoding: utf-8
class Catalog::ProductsController < ApplicationController

	include CatalogHelper

	def index
		@products = Catalog::Product.paginate(page: params[:page], per_page: 10)
	end

	def new
		@product = Catalog::Product.new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		createANDrender_catalog_item Catalog::Product.new(product_params)
	end

	def edit
		@product = Catalog::Product.find(params[:id])
		respond_to do |format|
			format.html { redirect_to catalog_products_path }
			format.js {render partial: "shared/js/item_edit", locals:{item: @product}}
		end
	end
	def update
		updateANDrender_catalog_item Catalog::Product.find(params[:id]), product_params
	end

	def search
		products = Catalog::Product.all
		filter_items(products, params[:filter])
	end

	private

	def product_params
		params.require(:product).permit(:name, :fullname, :idsymbol)
	end
end