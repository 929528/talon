# encoding: utf-8
class SessionsController < ApplicationController

	def new
	end

	def create
		user = User.find_by_name(params[:session][:name])
		if user && user.authenticate(params[:session][:password])
			flash[:notice] = "Добро пожаловать " + user.name.to_s
			sign_in user
			redirect_to user
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