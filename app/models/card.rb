class Card < ApplicationRecord
  mount_uploader :image, ImageUploader
  serialize :avatars, JSON # If you use SQLite, add this line.
  belongs_to :user
  has_many :creplies
end
