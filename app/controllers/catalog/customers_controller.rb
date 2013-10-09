class Catalog::CustomersController < Catalog::CatalogController
	before_filter :init_catalog

	def new
		@item = target.new
		@item.contracts.build(name: "Основной договор")
		super @item
	end
	def new_contract
		contract = Catalog::Contract.new(name: "Новый договор")
		respond_to {|format| format.js { render partial: "catalog/include_tab/add_include_tab", locals: {item: contract} }}
	end

	def get_contracts
		customer = Catalog::Customer.find_by_name(params[:item][:name])
		@contracts = Catalog::Contract.where(customer: customer).load
		respond_to  {|format| format.js }
	end

	def create
		super customer_params
	end

	def update
		super customer_params
	end

	private 

	def init_catalog
		self.target = Catalog::Customer
	end

	def customer_params
		params.require(:customer).permit(
			:name, 
			:fullname,
			contracts_attributes: [:id, :name, :default])
	end
end