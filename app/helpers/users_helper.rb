module UsersHelper
  def display_crown(rank_status)
     case rank_status
     when 1 then
      image_tag '王冠 金.jpeg'
     when 2 then
      image_tag '王冠 銀.jpeg'
     when 3 then
      image_tag '王冠 銅.jpeg'
    end
  end

  def display_user_icon(instance, icon_property)
    if instance.image?
      image_tag instance.image.url, class: "#{icon_property} rounded-circle"
    else
      image_tag 'no-image.png', class: "#{icon_property} rounded-circle"
    end
  end
end