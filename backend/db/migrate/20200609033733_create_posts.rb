class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :shop_name
      t.string :shop_address
      t.string :shop_access
      t.string :shop_url
      t.string :shop_image_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
