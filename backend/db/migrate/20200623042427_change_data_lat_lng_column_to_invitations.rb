class ChangeDataLatLngColumnToInvitations < ActiveRecord::Migration[5.2]
  def change
    change_column :invitations, :shop_latitude, :float
    change_column :invitations, :shop_longitude, :float
  end
end
