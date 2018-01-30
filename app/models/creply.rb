class Creply < ApplicationRecord
  belongs_to :user
  belongs_to :card
  validates :content, presence: true, length: { minimum:2, maximum: 200}
  validates :user_id, presence: true
  validates :card_id, presence: true
end
