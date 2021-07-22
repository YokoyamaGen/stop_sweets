class RemoveImageFromInformation < ActiveRecord::Migration[6.1]
  def change
    remove_column :information, :image, :string
  end
end
