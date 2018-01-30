class Nreply < ApplicationRecord
  belongs_to :user
  belongs_to :notice
  validates :content, presence: true, length: { minimum:2, maximum: 200}
  validates :user_id, presence: true
  validates :notice_id, presence: true
end
