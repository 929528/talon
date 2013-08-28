# encoding: utf-8
module ApplicationHelper
	def full_title(page_title)
		base_title = "Система учета талонов"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	def edit_item_path(item)
		string = "edit_#{item.class.name.downcase}_path"
		send string, item
	end
	def items_path(item)
		string = "#{item.class.name.downcase}s_path"
		send string
	end
end