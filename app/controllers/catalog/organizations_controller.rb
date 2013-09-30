class Catalog::OrganizationsController < ApplicationController

	def index
		@organizations = Catalog::Organization.paginate(page: params[:page], per_page: 7)
	end

	def new
		@organization = Catalog::Organization.new
		show_item @organization
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
			departments_attributes: [:name, :fullname, :phone, :address, :responsible])
	end
end