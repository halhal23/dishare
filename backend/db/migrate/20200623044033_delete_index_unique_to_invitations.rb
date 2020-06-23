class DeleteIndexUniqueToInvitations < ActiveRecord::Migration[5.2]
  def change
    remove_index :invitations, column: [:inviter_id,  :invited_id], name: 'index_invitations_on_inviter_id_and_invited_id', unique: true
  end
end
