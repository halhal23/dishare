class CommentSerializer < ActiveModel::Serializer
  attributes :id,
             :message,
             :user,
             :post,
             :created_at
  
  belongs_to :user
  belongs_to :post
end
