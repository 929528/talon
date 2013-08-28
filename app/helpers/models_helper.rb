# encoding: utf-8
module ModelsHelper

private

	def create_item(item, items)
		if item.save
			flash.now[:notice] = "Элемент #{item.fullname} успешно добавлен"
			respond_to do |format|
				format.html { redirect_to items_path(item) }
				format.js {render partial: "shared/subjects/js/submitModal", locals:{item: item, items: items}}
			end
		else
			flash.now[:error] = "Произошла ошибка при заполнении формы, элемент #{item.fullname} не сохранен"
			respond_to do |format|
				format.html { redirect_to items_path(item) }
				format.js {render partial: "shared/subjects/js/submitModal", locals:{item: item, items: items}}
			end
		end
	end
	def update_item(item, items)
		if item.update_attributes(params[%Q(#{item.class.name.downcase})])
			flash.now[:notice] = "Элемент: #{item.fullname} успешно обновлен"
			respond_to do |format|
				format.html { redirect_to items_path(item) }
				format.js {render partial: "shared/subjects/js/submitModal", locals:{item: item, items: items}} 
			end
		else
			flash.now[:error] = "Произошла ошибка при обновлении, элемента: #{item.fullname} не обновлен"
			respond_to do |format|
				format.html { redirect_to items_path(item) }
				format.js {render partial: "shared/subjects/js/submitModal", locals:{item: item, items: items}}
			end
		end
	end
end