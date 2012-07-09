module StaticPagesHelper
	def full_title(title)
		basic_title = "Sample Application"
		if title.blank?
			basic_title
		else
			"#{basic_title} | #{title}"
		end
	end
end
