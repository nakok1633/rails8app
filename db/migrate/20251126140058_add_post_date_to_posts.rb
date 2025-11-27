class AddPostDateToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :post_date, :date
  end
end
