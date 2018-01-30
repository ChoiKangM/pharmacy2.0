class Hreply < ApplicationRecord
  belongs_to :user
  belongs_to :handout
  validates :content, presence: true, length: { minimum:2, maximum: 200}
  validates :user_id, presence: true
  validates :handout_id, presence: true
end
