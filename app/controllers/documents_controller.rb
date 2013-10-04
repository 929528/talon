class DocumentsController < ApplicationController

	def index
		@type = Type.find_by_name params[:type]
		@documents = Document.where(type: @type).paginate(page: params[:page], per_page: 7)
	end

	def new
		@document = Document.new
		@document.type = Type.find(params[:type])
		show_item @document
	end
	def new_operation
		document_type = Type.find params[:document_type_id]
		barcode = params[:request][:barcode]
		operation = Operation.new document_type: document_type, talon_barcode: barcode
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
		document.department = current_user.department
		document.user = current_user
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
		document.department = current_user.department
		document.user = current_user
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
			:contract_id,
			:type_id,  
			:new_state,
			operations_attributes: [:action_id, :talon_barcode])
	end
	def update_document_params
		params.require(:document).permit(
			:contract_id,
			:new_state)
	end
end