# frozen_string_literal: true

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_uploader :image, ImageUploader
  
  validates :name, presence: true, uniqueness: true

  has_many :posts
  has_many :comments
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :active_invitations, class_name: "Invitations", foreign_key: "inviter_id", dependent: :destroy
  has_many :passive_invitations, class_name: "Invitations", foreign_key: "invited_id", dependent: :destroy

  # フォローの処理。フォロー相手が自分自身ではなく、既にフォローもしていない場合、新たなフォロー関係をcreateする。
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
