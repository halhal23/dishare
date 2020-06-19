class Photo < ApplicationRecord
  mount_uploader :picture, ImageUploader
  belongs_to :post
end
