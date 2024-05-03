class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :content, null: false, default: ''

      t.timestamps
    end
  end
end
