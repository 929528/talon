class Catalog::CustomersController < ApplicationController

	def index
		@customers = Catalog::Customer.paginate(page: params[:page], per_page: 8)
	end

	def new
		@customer = Catalog::Customer.new
		@customer.contracts.build(name: "Основной договор")
		show_item @customer
	end

	def get_contracts
		customer = Catalog::Customer.find_by_name(params[:customer][:name])
		contracts = customer.contracts.all.pluck(:name)
		respond_to do |format|
			format.js { render partial: "shared/js/add_contracts", locals: {items: contracts} }
		end
	end

	def create
		customer = Catalog::Customer.new(customer_params)
		if customer.save
			flash.now[:notice] = "Контрагент #{customer.fullname} создан" 
			perform_after_save customer
		else
			flash.now[:notice] = "Произошла ошибка при создании контрагента"
			show_errors_on customer
		end
	end
	def edit
		@customer = Catalog::Customer.find(params[:id])
		show_item @customer
	end

	def update
		customer = Catalog::Customer.find(params[:id])
		if customer.update_attributes(customer_params)
			flash.now[:notice] = "Контрагент #{customer.fullname} обновлен" 
			perform_after_save customer
		else
			flash.now[:notice] = "Произошла ошибка при обновлении контрагента"
			show_errors_on customer	
		end
	end

	def search
		customers = Catalog::Customer.all
		filter_items(customers, params[:filter])
	end

	private 

	def customer_params
		params.require(:customer).permit(
			:name, 
			:fullname,
			contracts_attributes: [:id, :name])
	end
end