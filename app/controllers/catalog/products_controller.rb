class Catalog::ProductsController < Catalog::CatalogController
	before_filter :init_catalog
	def new
		@item = target.new
		super @item
	end
	def create
		super product_params
	end
	def update
		super product_params
	end

	private

	def init_catalog
		self.target = Catalog::Product
	end
	def product_params
		params.require(:product).permit(:name, :fullname, :symbol)
	end
end