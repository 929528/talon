class Talon::DocumentController < ApplicationController
	def target= val
		@target = val
	end
	def target
		@target
	end
	def index
		@documents = target.paginate(page: params[:page], per_page: 7)
	end
	def new
		@document = target.new
		respond_to {|format| format.js { render partial: "shared/js/item", locals: {item: @document} }}
	end
	def create
		document = target.new document_params
		document.department = current_user.department
		document.user = current_user
		if document.save
			flash.now[:notice] = "Документ №: #{document.id} создан" 
			respond_to {|format| format.js { render partial: "shared/js/submit_modal", locals: {item: document} }}
		else
			respond_to {|format| format.js { render partial: "shared/js/add_errors", locals: {item: document} }}
		end
	end
	def new_operation action
		operation = action.new operation_params
		if operation.valid?
			respond_to {|format| format.js { render partial: "shared/js/add_operation", locals: {item: operation} }}
		else
			respond_to {|format| format.js { render partial: "shared/js/add_errors", locals: {item: operation} }}
		end
	end
	def edit
		@document = target.find(params[:id])
		respond_to {|format| format.js { render partial: "shared/js/item", locals: {item: @document} }}
	end
	def update
		document = target.find(params[:id])
		document.department = current_user.department
		document.user = current_user
		if document.update_attributes(update_document_params)
			flash.now[:notice] = "Документ #{document} обновлен" 
			respond_to {|format| format.js { render partial: "shared/js/submit_modal", locals: {item: document} }}
		else
			respond_to {|format| format.js { render partial: "shared/js/add_errors", locals: {item: document} }}
		end
	end
	private

	def document_params
		params.require(:document).permit(
			:new_state,
			:contract_id,
			operations_attributes: :talon_barcode
			)
	end

	def update_document_params
		params.require(:document).permit(
			:contract_id,
			:new_state)
	end
	def operation_params
		params.require(:operation).permit(
			:talon_barcode
			)
	end
end