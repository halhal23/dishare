class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: 'User'
  belongs_to :invited, class_name: 'User'

  validates :inviter_id, presence: true
  validates :invited_id, presence: true
end
