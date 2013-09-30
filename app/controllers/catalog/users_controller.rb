class Catalog::UsersController < ApplicationController

	def index
		@users = Catalog::User.paginate(page: params[:page], per_page: 8)
	end

	def show
		@user = Catalog::User.find(params[:id])
	end

	def new
		@user = Catalog::User.new
		show_item @user
	end

	def create
		user =  Catalog::User.new(user_params)
		if user.save
			flash.now[:notice] = "Пользователь #{user.fullname} создан" 
			perform_after_save user
		else
			flash.now[:notice] = "Произошла ошибка при создании пользователя"
			show_errors_on user
		end
	end
	def edit
		@user = Catalog::User.find(params[:id])
		show_item @user
	end

	def update
		user =  Catalog::User.find(params[:id])
		if user.update_attributes(user_params)
			flash.now[:notice] = "Поьзователь #{user.fullname} обновлен" 
			perform_after_save user
		else
			flash.now[:notice] = "Произошла ошибка при обновлении пользователя"
			show_errors_on user
		end
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