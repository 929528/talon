# encoding: utf-8
class CustomersController < ApplicationController

	before_filter :load
	
	def load
		@customers = Customer.paginate(page: params[:page], per_page: 6)
		@customer = Customer.new
	end

	def index
	end

	def create
		@customer = Customer.new(params[:customer])
		if @customer.save
			flash.now[:notice] = "Клиент: #{@customer.fullname} успешно добавлен"
			respond_to do |format|
				format.html { redirect_to customers_path }
				format.js
			end
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, клиент: #{@customer.fullname} не сохранен"
			respond_to do |format|
				format.html { redirect_to customers_path }
				format.js
			end
		end
	end
end