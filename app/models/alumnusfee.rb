class Alumnusfee < ApplicationRecord
  mount_uploaders :accounts, AccountUploader
  serialize :accounts, JSON # If you use SQLite, add this line.
  belongs_to :user
end
