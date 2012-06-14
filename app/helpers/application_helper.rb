# encoding: utf-8
module ApplicationHelper
	def body_id
		content_for?(:body_id) ? yield(:body_id) : 'page1'
	end
	
	def top_menu
		links = [
			['Tá rolando', root_path],
			['Vai bombar', root_path],
			['Galeria', root_path],
			['Promoções', root_path],
			['Que site é esse?', root_path],
			['Fala aí!', root_path],
		]
		content_tag(:ul, links.collect{|t| content_tag(:li, link_to(t[0],t[1]))}.join.html_safe, :id => 'menu').html_safe
	end
end
