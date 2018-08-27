class MakePublic < ApplicationRecord
  mount_uploaders :informations, InformationUploader
  serialize :informations, JSON # If you use SQLite, add this line.
  belongs_to :user
end
