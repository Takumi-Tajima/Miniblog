class AddBlogUrlToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :blog_url, :string, null: false, default: ''
  end
end
