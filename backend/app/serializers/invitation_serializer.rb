class InvitationSerializer < ActiveModel::Serializer
  attributes :id,
             :shop_name,
             :shop_site_url,
             :shop_image_url,
             :shop_address,
             :something_to_eat,
             :invite_date,
             :comment
  
  belongs_to :inviter
  belongs_to :invited
  has_many :invite_conversations
end
