class CarImport::Validators::ColumnValidator

  MANDATORY_COLUMNS = ["id", "manufacturer", "price", "used"]

  include Virtus.model
  attribute :mandarory_columns, Array, default: MANDATORY_COLUMNS
  attribute :heareds, Array

  def self.call(heareds)
    validator = self.new(heareds: heareds)
    validator.missing_headers
  end

  def self.mandarory_columns
    MANDATORY_COLUMNS
  end

  def missing_headers
    mandarory_columns - heareds
  end

end
