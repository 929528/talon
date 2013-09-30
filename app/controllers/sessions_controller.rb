class SessionsController < ApplicationController

	def new
		if signed_in?
			redirect_to catalog_user_path(current_user), error: "Добро пожаловать " + current_user.name.to_s
		else
			render 'new'
		end
	end

	def create
		user = Catalog::User.find_by_name(params[:session][:name])
		if user && user.authenticate(params[:session][:password])
			sign_in user
			redirect_to user, error: "Добро пожаловать " + user.name.to_s
		else
			flash.now[:error] = 'Неверное имя пользователя или пароль.' 
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end