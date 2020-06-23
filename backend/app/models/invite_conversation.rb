class InviteConversation < ApplicationRecord
  belongs_to :user
  belongs_to :invitation
end
