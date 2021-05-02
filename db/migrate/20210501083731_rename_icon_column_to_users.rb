class RenameIconColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :icon, :image
  end
end
