class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :name,
             :image,
             :created_at
            
  has_many :posts, serializer: PostSerializer
  has_many :followings
  has_many :followers
end
