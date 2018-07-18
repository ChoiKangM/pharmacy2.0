class Alumnusfee < ApplicationRecord
  mount_uploader :account, AccountUploader
  belongs_to :user
end
