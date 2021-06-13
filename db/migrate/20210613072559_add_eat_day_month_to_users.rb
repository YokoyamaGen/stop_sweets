class AddEatDayMonthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :eat_day_month, :integer, default: 0
  end
end
