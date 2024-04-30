class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :contents, null: false, default: ''

      t.timestamps
    end
  end
end
