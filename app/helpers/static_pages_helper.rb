module StaticPagesHelper
	def full_title(title)
		basic_title = "Micropost Application"
		if title.blank?
			basic_title
		else
			"#{basic_title} | #{title}"
		end
	end
end
