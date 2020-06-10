class AddShopCategoryToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :shop_category, :string
  end
end
