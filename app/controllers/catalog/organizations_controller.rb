# encoding: utf-8
class Catalog::OrganizationsController < ApplicationController

	include CatalogHelper

	def index
		@organizations = Catalog::Organization.paginate(page: params[:page], per_page: 10)
	end

	def new
		@organization = Catalog::Organization.new
		respond_to do |format|
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		createANDrender_catalog_item Catalog::Organization.new(organization_params)
	end

	def edit
		@organization = Catalog::Organization.find(params[:id])
		respond_to do |format|
			format.js { render partial: "shared/js/item_edit", locals:{item: @organization}}
		end
	end

	def update
		updateANDrender_catalog_item Catalog::Organization.find(params[:id]), organization_params
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