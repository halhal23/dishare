class RenameLatLngColumnToInvitations < ActiveRecord::Migration[5.2]
  def change
    rename_column :invitations, :longitude, :shop_longitude
    rename_column :invitations, :latitude, :shop_latitude
  end
end
