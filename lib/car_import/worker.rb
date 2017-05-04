class CarImport::Worker

  include Virtus.model
  attribute :import_record, Integer

  def self.call!(import_record_id)
    import_record = ImportRecord.find(import_record_id)
    worker = self.new(import_record: import_record)
    worker.import
  end

  def import
    line = 1

    CSV.new(open(carrierwave_path(import_record)), headers: true).each do |row|
      validator = CarImport::Validators::RowValidator.new(row: row.to_h, line: line)

      validator.on_success do |data_object|
        persist!(data_object)
      end

      validator.on_error do |error_object|
        # NOTE: Do what you want with error object.
      end

      line += 1
    end
  end

  def persist!(data_object)
    car = Car.find_by(id: data_object.id)

    if car.present?
      car.update(data_object.to_h)
    else
      Car.create!(data_object.to_h)
    end
  end

  private

    def carrierwave_path(import_record)
      Util::CarrierwavePathHelper.path_to_open(import_record.file)
    end

end
