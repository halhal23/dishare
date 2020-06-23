class CreateInviteConversations < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_conversations do |t|
      t.text :message
      t.references :user, foreign_key: true
      t.references :invitation, foreign_key: true

      t.timestamps
    end
  end
end
