class ImportRecord < ApplicationRecord
  mount_uploader :file, CarUploader

  validates :file, presence: true
  # validates_format_of :file, with: %r{\.(csv|xlsx|xls)\z}i, message: "Invalid file format."

end
