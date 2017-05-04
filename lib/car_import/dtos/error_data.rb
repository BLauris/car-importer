class CarImport::Dtos::ErrorData

  include Virtus.model
  attribute :line, Integer
  attribute :messages, String

end
