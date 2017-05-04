class UploadCsvFrom
  include ActiveModel::Model
  include Virtus.model

  attribute :file, String
  attribute :import_record, ImportRecord, default: ImportRecord.new

  validates :file, presence: true
  # validates_format_of :file, with: %r{\.(csv|xlsx|xls)\z}i, message: "Invalid file format."
  validate :has_mandatory_columns?

  def save
    if valid?
      persist!
    else
      false
    end
  end

  private

    def persist!
      import_record.file = file
      import_record.save!
    end

    def has_mandatory_columns?
      if file.present?
        headers = CSV.open(file.path, 'r') { |csv| csv.first }
        missing_columns = CarImport::Validators::ColumnValidator.call(headers)

        if missing_columns.any?
          errors.add(:file, "CSV File has some missing columns: #{missing_columns.to_sentence}")
        end
      end
    end

end
