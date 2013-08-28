# encoding: utf-8
class OrganizationsController < ApplicationController
	
	before_filter :load

	def load
		@organizations = Organization.paginate(page: params[:page], per_page: 15)
		@organization = Organization.new
		@organization.departments.new(name: "Основное подразделение")
	end

	def index
	end

	def new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/subjects/js/new" }
		end
	end

	def create
		@organization = Organization.new(params[:organization])
		create_item @organization, @organizations
	end

	def edit
		@organization = Organization.find(params[:id])
		respond_to do |format|
			format.html { redirect_to organizations_path }
			format.js { render partial: "shared/subjects/js/edit", locals:{item: @organization}}
		end
	end

	def update
		@organization = Organization.find(params[:id])
		update_item @organization, @organizations
	end
end