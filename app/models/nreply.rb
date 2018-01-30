class Nreply < ApplicationRecord
  belongs_to :user
  belongs_to :notice
end
