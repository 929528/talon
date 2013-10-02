class Catalog::OrganizationsController < ApplicationController

	def index
		@organizations = Catalog::Organization.paginate(page: params[:page], per_page: 7)
	end

	def new
		@organization = Catalog::Organization.new
		@organization.departments.build(name: "Основное подразделение") 
		show_item @organization
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
		organization = Catalog::Organization.new(organization_params)
		if organization.save
			flash.now[:notice] = "Организация #{organization.fullname} создана" 
			perform_after_save organization
		else
			flash.now[:notice] = "Произошла ошибка при создании организации"
			show_errors_on organization
		end
	end

	def edit
		@organization = Catalog::Organization.find(params[:id])
		show_item @organization
	end

	def update
		organization = Catalog::Organization.find(params[:id])
		if organization.update_attributes(organization_params)
			flash.now[:notice] = "Организация #{organization.fullname} обновлена" 
			perform_after_save organization
		else
			flash.now[:notice] = "Произошла ошибка при обновлении Организации"
			show_errors_on organization	
		end
	end

	def search
		organizations = Catalog::Organization.all
		filter_items organizations, params[:filter]
	end

	private

	def organization_params
		params.require(:organization).permit(:name, :fullname, 
			departments_attributes: [:id, :name, :fullname])
	end
end