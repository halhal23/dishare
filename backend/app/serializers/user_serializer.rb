class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :name,
             :image,
             :created_at
            
  has_many :posts, serializer: PostSerializer
  has_many :followings
  has_many :followers
  has_many :active_invitations
  has_many :passive_invitations

end
