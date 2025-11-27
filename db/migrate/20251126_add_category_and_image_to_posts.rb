class AddCategoryAndImageToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :category, :string, default: 'general'
    add_column :posts, :image, :string
  end
end
