class ImportRecord < ApplicationRecord
  mount_uploader :file, CarUploader

  validates :file, presence: true

end
