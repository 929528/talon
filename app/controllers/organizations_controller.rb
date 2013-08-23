# encoding: utf-8
class OrganizationsController < ApplicationController
	
	before_filter :load

	def load
		@organizations = Organization.paginate(page: params[:page], per_page: 7)
		@organization = Organization.new
		@organization.departments.new(name: "Основное подразделение")
	end

	def index
	end

	def create
		@organization = Organization.new(params[:organization])
		if @organization.save
			flash.now[:notice] = "Организация: #{@organization.fullname} успешно добавлена"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js
			end
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, организация: #{@organization.fullname} не сохранена"
			respond_to do |format|
				format.html { redirect_to organizations_path }
				format.js 
			end
		end
	end
end

