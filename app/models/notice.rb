class Notice < ApplicationRecord
  belongs_to :user
  has_many :nreplies
end
