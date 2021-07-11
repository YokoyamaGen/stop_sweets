class RemoveGoalImageFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :goal_image, :string

    remove_column :users, :motivation, :text
  end
end
