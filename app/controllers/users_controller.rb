# encoding: utf-8
class UsersController < ApplicationController

	before_filter :load
	
	def load
		if (defined? params[:filter]) && !(params[:filter].blank?)
			@users = User.where("name = ?", params[:filter])
		else
			@users = User.paginate(page: params[:page], per_page: 9)
		end
		@user = User.new
	end
	
	def index
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/subjects/js/filter", locals: {items: @users} }
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/subjects/js/new" }
		end
	end

	def create
		@user= User.new(params[:user])
		create_item @user, @users
	end
	def edit
		@user = User.find(params[:id])
		respond_to do |format|
			format.html { redirect_to users_path }
			format.js {render partial: "shared/subjects/js/edit", locals:{item: @user}}
		end
	end

	def update
		@user = User.find(params[:id])
		update_item @user, @users
	end
end