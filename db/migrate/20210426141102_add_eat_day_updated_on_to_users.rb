class AddEatDayUpdatedOnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :eat_day_updated_on, :date, null: false, default: Date.today
  end
end
