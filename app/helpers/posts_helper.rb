module PostsHelper
  def display_user_icon_post(instance, icon_property="", routing)
    if instance.image?
      link_to image_tag(instance.image.url, class: "#{icon_property}"), routing
    else
      link_to image_tag('no-image.png', class: "#{icon_property}"), routing
    end
  end
end