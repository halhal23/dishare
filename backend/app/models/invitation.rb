class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: 'User', foreign_key: "inviter_id"
  belongs_to :invited, class_name: 'User', foreign_key: "invited_id"

  validates :inviter_id, presence: true
  validates :invited_id, presence: true
end
