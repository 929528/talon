# encoding: utf-8
class DocumentsController < ApplicationController

	include CatalogHelper

	def index
		@action = Action.find_by_name(params[:type])
		@documents = Document.paginate(page: params[:page], per_page: 10).where(action_id: @action)
	end

	def new
		@document = Document.new(action: Action.find(params[:type]))
		respond_to do |format|
			format.js { render partial: "shared/js/item_new" }
		end
	end

	def create
		action = Action.find(document_params[:action][:id])
		state = DocumentState.find_by_name(document_params[:document_state][:name])
		operations = document_params[:operation]
		document = Document.new(state: state, action: action)
		operations.each do |operation|
			barcode = operation[:talon][:barcode]
			document.operations.build(talon: Catalog::Talon.find_or_initialize_by(barcode: barcode), 
				action: action)
		end
		createANDrender_catalog_item document
	end

	def edit
		@document = Document.find(params[:id])
		@operations = @document.operations.all
		respond_to do |format|
			format.js { render partial: "shared/js/item_edit", locals:{item: @document}}
		end
	end

	private

	def document_params
		params.require(:document).permit(document_state: :name, action: :id, :operation => [talon: :barcode])
	end
end