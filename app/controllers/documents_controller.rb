class DocumentsController < ApplicationController

	def index
		@action = Action.find_by_name(params[:type])
		@documents = Document.paginate(page: params[:page], per_page: 7)
	end

	def new
		@document = Document.new(action: Action.find(params[:type]))
		show_item @document
	end

	def operation_new
		barcode = params[:request][:barcode]
		action = Action.find_by_name(params[:document_action])
		operation = Operation.new action: action, talon_barcode: barcode
		if operation.valid?
			respond_to do |format|
				format.js { render partial: "shared/js/add_operation", locals: {item: operation} }
			end
		else
			respond_to do |format|
				format.js { render partial: "shared/js/add_errors", locals: {item: operation} }
			end
		end
	end

	def create
		document = Document.new(document_params)
		if document.save
			flash.now[:notice] = "Документ №: #{document.id} создан" 
			perform_after_save document
		else
			flash.now[:notice] = "Произошла ошибка при создании документа"
			show_errors_on document
		end
	end

	def edit
		@document = Document.find(params[:id])
		show_item @document
	end

	def update
		document = Document.find(params[:id])
		if document.update_attributes(update_document_params)
			flash.now[:notice] = "Документ #{document} обновлен" 
			perform_after_save document
		else
			flash.now[:notice] = "Произошла ошибка при обновлении документа"
			show_errors_on document	
		end
	end

	private

	def document_params
		params.require(:document).permit(
			:action_id,  
			:new_document_state_name,
			operations_attributes: [:action_id, :talon_barcode])
	end
	def update_document_params
		params.require(:document).permit(
			:new_document_state_name)
	end
end