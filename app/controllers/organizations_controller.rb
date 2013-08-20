# encoding: utf-8
class OrganizationsController < ApplicationController
	
	before_filter :load

	def load
		@organizations = Organization.paginate(page: params[:page], per_page: 6)
		@organization = Organization.new
		@organization.departments.new(name: "Основное подразделение")
	end

	def index
	end

	def create
		@organization = Organization.new(params[:organization])
		if @organization.save
			flash[:notice] = "Организация добавлена"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js
			end
		else
			flash[:error] = "Ошибка"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js
			end
		end
	end
end

