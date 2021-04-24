class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_column :users, :cost, :integer, default: 0
    add_column :users, :icon, :string
    add_column :users, :goal_image, :string
    add_column :users, :motivation, :text
    add_column :users, :eat_day, :integer, default: 0
  end
end
