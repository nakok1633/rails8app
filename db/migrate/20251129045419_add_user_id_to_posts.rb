class AddUserIdToPosts < ActiveRecord::Migration[8.1]
  def change
    add_reference :posts, :user, foreign_key: true, default: 1
    change_column_null :posts, :user_id, false
  end
end
