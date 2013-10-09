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

	def modal_title item
		"#{item} :: #{params[:action]}"
	end

	def catalog?(item)
		item.class.name.split("::").first == "Catalog"
	end
	def document?(item)
		!catalog? item
	end

	def model_icon(item)
		if document? item
			case item.state.name
			when "write"
				"icon-check icon-2x"
			when "save"
				"icon-save icon-2x"
			end
		elsif catalog? item
			"icon-book icon-2x"
		end
	end
end