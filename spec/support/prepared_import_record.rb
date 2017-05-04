class PreparedImportRecord

  attr_reader :import_record, :file

  def initialize(file)
    @file = file
    @import_record = ImportRecord.new

    save_import_record
  end

  def save_import_record
    import_record.file = file
    import_record.save
  end

end
