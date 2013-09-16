# encoding: utf-8
module CatalogHelper
	def filter_items(items, filter)
		items = items.where("name = ?", params[:filter]) unless params[:filter].blank?
		items = items.paginate(page: params[:page], per_page: 10)
		respond_to do |format|
			format.js {render partial: "shared/js/item_search", locals:{items: items}}
		end
	end

	def createANDrender_catalog_item(item)
		if item.valid? && item.save
			flash.now[:notice] = "Номенклатура: #{item} успешно добавлена"
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, номенклатура: #{item} не сохранена"
		end
		submitANDrender item
	end
	def updateANDrender_catalog_item(item, params)
		if item.update_attributes(params)
			flash.now[:notice] = "Номенклатура: #{item} успешно обновлена"
		else
			flash.now[:error] = "Произошла ошибка при обновлении номенклатуры: #{item} не обновлена"
		end
		submitANDrender item
	end

	private 

	def submitANDrender(item)
		if item.errors.any?
			respond_to do |format|
				format.js {render partial: "shared/js/add_errors", locals:{item: item}}
			end
		else
			respond_to do |format|
				format.js {render partial: "shared/js/submit_modal", locals:{item: item}}
			end
		end
	end
end