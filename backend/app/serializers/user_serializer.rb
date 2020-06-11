class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :email,
             :name,
             :image
            
  has_many :posts, serializer: PostSerializer
  has_many :followings
  has_many :followers
end
