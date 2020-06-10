class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  validates :content, presence: true
end
