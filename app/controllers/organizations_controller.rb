# encoding: utf-8
class OrganizationsController < ApplicationController
	
	before_filter :load, except: :edit

	def load
		if (defined? params[:filter]) && !(params[:filter].blank?)
			@organizations = Organization.where("name = ?", params[:filter])
		else
			@organizations = Organization.paginate(page: params[:page], per_page: 10)
		end
		@organization = Organization.new
		@organization.departments.build(name: "Основное подразделение")
	end

	def index
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_filter", locals: {items: @organizations} }
		end
	end

	def new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		organization = Organization.new(organization_params)
		if organization.valid? && organization.save
			flash.now[:notice] = "Организация #{organization.fullname} успешно добавлена"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: organization, items: @organizations}}
			end
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, организация #{organization.fullname} не сохранена"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: organization, items: @organizations}}
			end
		end
	end

	def edit
		@organization = Organization.find(params[:id])
		respond_to do |format|
			format.html { redirect_to organizations_path }
			format.js { render partial: "shared/js/item_edit", locals:{item: @organization}}
		end
	end

	def update
		organization = Organization.find(params[:id])
		if organization.valid? && organization.update_attributes(organization_params)
			flash.now[:notice] = "Организация: #{organization.fullname} успешно обновлена"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: organization, items: @organizations}} 
			end
		else
			flash.now[:error] = "Произошла ошибка при обновлении организации: #{organization.fullname} не обновлена"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: organization, items: @organizations}}
			end
		end
	end

	private

	def organization_params
		params.require(:organization).permit(:name, :fullname, 
			departments_attributes: [:name, :fullname, :phone, :address, :responsible])
	end

end