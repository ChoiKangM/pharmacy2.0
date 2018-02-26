class MakePublic < ApplicationRecord
  mount_uploader :information, InformationUploader
  belongs_to :user
end
