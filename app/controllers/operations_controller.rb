# encoding: utf-8
class OperationsController < ApplicationController
	def new
		barcode = params[:request][:barcode]
		talon = Catalog::Talon.find_or_initialize_by(barcode: barcode)
		operation = Operation.new(talon: talon)
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
end