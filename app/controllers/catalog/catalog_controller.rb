class Catalog::CatalogController < ApplicationController
	def target= val
		@target = val
	end
	def target
		@target
	end
	def index
		@items = target.paginate(page: params[:page], per_page: 8)
	end
	def new item
		respond_to {|format| format.js { render partial: "shared/js/item", locals: {item: item} }}
	end
	def create param
		item = target.new param
		if item.save
			flash.now[:notice] = "#{item.fullname} создан" 
			respond_to {|format| format.js { render partial: "shared/js/submit_modal", locals: {item: item} }}
		else
			respond_to {|format| format.js { render partial: "shared/js/add_errors", locals: {item: item} }}
		end
	end
	def edit
		@item = target.find(params[:id])
		respond_to {|format| format.js { render partial: "shared/js/item", locals: {item: @item} }}
	end
	def update param
		item = target.find(params[:id])
		if item.update_attributes param
			flash.now[:notice] = "#{item.fullname} обновлен" 
			respond_to {|format| format.js { render partial: "shared/js/submit_modal", locals: {item: item} }}
		else
			flash.now[:notice] = "Произошла ошибка при обновлении"
			respond_to {|format| format.js { render partial: "shared/js/add_errors", locals: {item: item} }}
		end
	end
end