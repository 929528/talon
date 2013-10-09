class Catalog::OrganizationsController < Catalog::CatalogController

	before_filter :init_catalog

	def new
		@item = target.new
		@item.departments.build(name: "Основное подразделение") 
		super @item
	end
	def new_department
		department = Catalog::Department.new(name: "Новое подразделение")
		respond_to do |format|
			format.js { render partial: "catalog/include_tab/add_include_tab", locals: {item: department} }
		end
	end
	def get_departments
		organization = Catalog::Organization.find_by_name(params[:item][:name])
		@departments = Catalog::Department.where(organization: organization).load
		respond_to do |format|
			format.js 
		end
	end

	def create
		super organization_params
	end

	def update
		super organization_params
	end

	private

	def init_catalog
		self.target = Catalog::Organization
	end

	def organization_params
		params.require(:organization).permit(:name, :fullname, 
			departments_attributes: [:id, :name, :fullname])
	end
end