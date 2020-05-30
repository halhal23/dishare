class RemoveIndexEmailFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_index :users, column: :email, unique: true
  end
end
