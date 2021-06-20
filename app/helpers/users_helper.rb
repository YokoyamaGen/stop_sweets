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
end