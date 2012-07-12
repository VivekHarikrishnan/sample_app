module UsersHelper

	def gravatar_for(user, options = {size: 50, class_name: 'gravatar'})
		size = options[:size]
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"

		image_tag gravatar_url, alt: user.name, class: options[:class_name]
	end
end
