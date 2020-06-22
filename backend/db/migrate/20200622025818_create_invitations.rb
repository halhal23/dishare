class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.references :inviter, foreign_key: { to_table: :users }
      t.references :invited, foreign_key: { to_table: :users }
      t.string :shop_name
      t.string :shop_site_url
      t.string :shop_image_url
      t.string :shop_address
      t.string :something_to_eat
      t.date :invite_date, null: false
      t.text :comment, null: false

      t.timestamps

      t.index [:inviter_id, :invited_id], unique: true
    end
  end
end
