# encoding: utf-8
class CustomersController < ApplicationController

	before_filter :load, except: :edit
	
	def load
		if (defined? params[:filter]) && !(params[:filter].blank?)
			@customers = Customer.where("name = ?", params[:filter])
		else
			@customers = Customer.paginate(page: params[:page], per_page: 9)
		end
		@customer = Customer.new
	end

	def index
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_filter", locals: {items: @customers} }
		end
	end

	def new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		customer = Customer.new(customer_params)
		if customer.valid? && customer.save
			flash.now[:notice] = "Контрагент: #{customer.fullname} успешно добавлен"
			respond_to do |format|
				format.html { redirect_to customers_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: customer, items: @customers}}
			end
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, контрагент: #{customer.fullname} не сохранен"
			respond_to do |format|
				format.html { redirect_to customers_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: customer, items: @customers}}
			end
		end
	end
	def edit
		@customer = Customer.find(params[:id])
		respond_to do |format|
			format.html { redirect_to customers_path }
			format.js {render partial: "shared/js/item_edit", locals:{item: @customer}}
		end
	end

	def update
		customer = Customer.find(params[:id])
		if customer.valid? && customer.update_attributes(customer_params)
			flash.now[:notice] = "Контрагент: #{customer.fullname} успешно обновлен"
			respond_to do |format|
				format.html { redirect_to customers_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: customer, items: @customers}} 
			end
		else
			flash.now[:error] = "Произошла ошибка при обновлении контрагента: #{customer.fullname} не обновлен"
			respond_to do |format|
				format.html { redirect_to customers_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: customer, items: @customers}}
			end
		end
	end

	private 

	def customer_params
		params.require(:customer).permit(:name, :fullname)
	end
end