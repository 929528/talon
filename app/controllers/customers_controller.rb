# encoding: utf-8
class CustomersController < ApplicationController

	before_filter :load
	
	def load
		@customers = Customer.paginate(page: params[:page], per_page: 15)
		@customer = Customer.new
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
		@customer = Customer.new(params[:customer])
		create_item @customer, @customers
	end
	def edit
		@customer = Customer.find(params[:id])
		respond_to do |format|
			format.html { redirect_to customers_path }
			format.js {render partial: "shared/subjects/js/edit", locals:{item: @customer}}
		end
	end

	def update
		@customer = Customer.find(params[:id])
		update_item @customer, @customers
	end
end