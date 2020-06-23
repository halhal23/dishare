class AddColumnToInvitations < ActiveRecord::Migration[5.2]
  def change
    add_column :invitations, :longitude, :decimal
    add_column :invitations, :latitude, :decimal
  end
end
