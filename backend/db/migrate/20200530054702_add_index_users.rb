class AddIndexUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    remove_index :users, column: :name, unique: true
  end
end
