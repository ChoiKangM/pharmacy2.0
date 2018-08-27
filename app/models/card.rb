class Card < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images, JSON # If you use SQLite, add this line.
  belongs_to :user
  has_many :creplies
end
