class ImportPreviewPresenter

  include Virtus.model
  attribute :import_record_id, Integer
  attribute :valid_rows, Array, default: []
  attribute :invalid_rows, Array, default: []
  attribute :columns, Array, default: :init_mandatory_columns

  def total_count
    valid_count + invalid_count
  end

  def valid_count
    valid_rows.size
  end

  def invalid_count
    invalid_rows.size
  end

  def parse_data
    import_record = ImportRecord.find(import_record_id)
    line = 1

    CSV.new(open(carrierwave_path(import_record)), headers: true).each do |row|
      validator = CarImport::Validators::RowValidator.new(row: row.to_h, line: line)

      validator.on_success do |data_object|
        valid_rows << data_object
      end

      validator.on_error do |error_object|
        invalid_rows << error_object
      end

      line += 1
    end
  end

  private

    def carrierwave_path(import_record)
      Util::CarrierwavePathHelper.path_to_open(import_record.file)
    end

    def init_mandatory_columns
      CarImport::Validators::ColumnValidator.mandarory_columns
    end

end
