class AddResultColumnToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :result, :integer, default: 0
  end
end
