# encoding: utf-8
class Catalog::CustomersController < ApplicationController

	include CatalogHelper

	def index
		@customers = Catalog::Customer.paginate(page: params[:page], per_page: 10)
	end

	def new
		@customer = Catalog::Customer.new
		respond_to do |format|
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		createANDrender_catalog_item Catalog::Customer.new(customer_params)
	end
	def edit
		@customer = Catalog::Customer.find(params[:id])
		respond_to do |format|
			format.js {render partial: "shared/js/item_edit", locals:{item: @customer}}
		end
	end

	def update
		updateANDrender_catalog_item Catalog::Customer.find(params[:id]), customer_params
	end

	def search
		customers = Catalog::Customer.all
		filter_items(customers, params[:filter])
	end

	private 

	def customer_params
		params.require(:customer).permit(:name, :fullname)
	end
end