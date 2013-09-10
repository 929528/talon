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
			format.js { render partial: "shared/js/item_filter", locals: {items: @users} }
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		respond_to do |format|
			format.html {  }
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		user = User.new(user_params)
		if user.valid? && user.save
			flash.now[:notice] = "Пользователь #{user.fullname} успешно добавлен"
			respond_to do |format|
				format.html { redirect_to users_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: user, items: @users}}
			end
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, пользователь #{user.fullname} не сохранен"
			respond_to do |format|
				format.html { redirect_to users_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: user, items: @users}}
			end
		end
	end
	def edit
		@user = User.find(params[:id])
		respond_to do |format|
			format.html { redirect_to users_path }
			format.js {render partial: "shared/js/item_edit", locals:{item: @user}}
		end
	end

	def update
		user = User.find(params[:id])
		if user.update_attributes(user_params)
			flash.now[:notice] = "Пользователь: #{user.fullname} успешно обновлен"
			respond_to do |format|
				format.html { redirect_to users_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: user, items: @users}} 
			end
		else
			flash.now[:error] = "Произошла ошибка при обновлении пользователя: #{user.fullname} не обновлен"
			respond_to do |format|
				format.html { redirect_to users_path }
				format.js {render partial: "shared/js/submitModal", locals:{item: user, items: @users}}
			end
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :fullname, :email, :password, :password_confirmation)
	end
end