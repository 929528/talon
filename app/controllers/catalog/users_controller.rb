# encoding: utf-8
class Catalog::UsersController < ApplicationController

	include CatalogHelper
	
	def index
		@users = Catalog::User.paginate(page: params[:page], per_page: 10)
	end

	def show
		@user = Catalog::User.find(params[:id])
	end

	def new
		@user = Catalog::User.new
		respond_to do |format|
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		createANDrender_catalog_item Catalog::User.new(user_params)
	end
	def edit
		@user = Catalog::User.find(params[:id])
		respond_to do |format|
			format.js {render partial: "shared/js/item_edit", locals:{item: @user}}
		end
	end

	def update
		updateANDrender_catalog_item Catalog::User.find(params[:id]), user_params
	end

	def search
		users = Catalog::User.all
		filter_items(users, params[:filter])
	end

	private

	def user_params
		params.require(:user).permit(:name, :fullname, :email, :password, :password_confirmation)
	end
end