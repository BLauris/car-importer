class CarImport::Dtos::CarData

  include Virtus.model
  attribute :id, String
  attribute :manufacturer, String
  attribute :price, BigDecimal
  attribute :used, String
  attribute :note, String, default: ""

end
