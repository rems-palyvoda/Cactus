class Post < ApplicationRecord
  before_save { self.media = media.split("=").last }
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :content, presence: true, length: {maximum: 200}
  validates :user_id, presence: true
  mount_uploader :image, AvatarUploader
end
