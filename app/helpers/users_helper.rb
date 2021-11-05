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

  def check_user_rank(rank, i, before_user_continue_day, rank_status)
    if i == 1 || @before_user_continue_day != rank[1]
      @rank_status = i
      @before_user_continue_day = rank[1]
    end
  end
end