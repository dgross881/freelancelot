module UsersHelper
 def avatar_for(user, options = { size: 50 })
    avatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    image_tag(current_user.avatar.url(:small), alt: user.name, class: "gravatar")
  end
end

  
