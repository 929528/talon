module ApplicationHelper
	def full_title(page_title)
		base_title = "Система учета талонов"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def get_uniq_id
		Time.now.to_i
	end

	def get_customer_names
		Catalog::Customer.uniq.pluck(:name)
	end
	def get_organization_names
		Catalog::Organization.uniq.pluck(:name)
	end

	def modal_type(item)
		a = Hash.new("")
		type = item.class.name.split("::").first.downcase
		view = item.class.name.split("::").last.downcase
		a["type"] += type
		a["new"] += item.new_record?.to_json
		a["view"] += view
		return a.to_json
	end

	def modal_title(item)
		case params[:action]
		when "new" then "Создать: #{model_name item}"
		when "edit" then "Редакировать: #{model_name item} № #{item.id}"
		when "show" then "Просмотр: #{model_name item}"
		end
	end

	def catalog?(item)
		item.class.name.split("::").first == "Catalog"
	end
	def document?(item)
		item.class.name == "Document"
	end
	def model_icon(item)
		if document? item
			case item.state.name
			when "write"
				"icon-check icon-2x text-success"
			when "save"
				"icon-save icon-2x text-error"
			end
		elsif catalog? item
			"icon-book icon-2x text-info"
		end
	end
	def model_name(item)
		if document? item
			case item.action.name
			when "issue"
				"Реализация талонов"
			when "repaid"
				"Погашение талонов"
			end
		elsif catalog? item
			case item.class.name.split("::").last
			when "Customer" then "Контрагент"
			when "Organization" then "Организация"
			when "Product" then "Продукт"
			when "User" then "Пользователь"
			end
		end
	end

	def perform_after_save(item)
		respond_to do |format|
			format.js { render partial: "shared/js/submit_modal", locals: {item: item} }
		end 
	end
	def show_errors_on(item)
		respond_to do |format|
			format.js { render partial: "shared/js/add_errors", locals: {item: item} }
		end
	end
	def show_item(item)
		respond_to do |format|
			format.js { render partial: "shared/js/item", locals: {item: item} }
		end
	end
	def filter_items(items, filter)
		items = items.where("name = ?", params[:filter]) unless params[:filter].blank?
		items = items.paginate(page: params[:page], per_page: 10)
		respond_to do |format|
			format.js {render partial: "shared/js/item_search", locals:{items: items}}
		end
	end
end