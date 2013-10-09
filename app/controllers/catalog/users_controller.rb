class Catalog::UsersController < Catalog::CatalogController
	before_filter :init_catalog

	def show
		@item = target.find(params[:id])
	end

	def new
		@item = target.new
		@item.build_department
		@item.department.build_organization
		super @item
	end

	def create
		super user_params
	end
	def update
		super user_params
	end

	private

	def init_catalog
		self.target = Catalog::User
	end
	def user_params
		params.require(:user).permit(:name, :fullname, :email, :password, :password_confirmation, :department_id)
	end
end