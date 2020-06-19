class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :shop_name,
             :shop_category,
             :shop_address,
             :shop_access,
             :shop_url,
             :shop_image_url,
             :user_id,
             :created_at
  
  belongs_to :user
  has_many :photos
  has_many :comments, serializer: CommentSerializer
end
