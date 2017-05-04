class ImportCarRepo
  include Virtus.model
  attribute :file, String
  attribute :errors, Hash, default: {}

end
