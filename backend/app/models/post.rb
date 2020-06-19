class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :photos, dependent: :destroy
  validates :content, presence: true
end
