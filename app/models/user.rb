class User < ApplicationRecord
  has_one_attached :profile_picture
  validates :profile_picture, presence: true
end
