ActiveAdmin.register User do

  permit_params :name, :age, :cost, :image, :eat_day, :eat_day_month
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :cost, :image, :goal_image, :motivation, :eat_day, :eat_day_updated_on, :eat_day_month
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :cost, :image, :goal_image, :motivation, :eat_day, :eat_day_updated_on, :eat_day_month]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
