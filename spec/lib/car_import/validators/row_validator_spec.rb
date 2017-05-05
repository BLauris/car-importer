require "rails_helper"

describe CarImport::Validators::RowValidator do
  let(:callable_double) {double(:callable)}
  let(:valid_row) { {"id"=>"1", "manufacturer"=>"Honda", "price"=>"1340", "used"=>"FALSE", "note"=>nil} }
  let(:invalid_row) { {"id"=>"1", "manufacturer"=>"", "price"=>"non", "used"=>"FALSE", "note"=>nil} }

  it "it does not return any messages on successful validation" do
    validator = CarImport::Validators::RowValidator.new(row: valid_row, line: 3)

    validator.on_error do |error_object|
      callable_double.test
    end

    expect(callable_double).not_to receive(:error)

    validator.on_success do |data_object|
      expect(data_object.id).to eq(valid_row["id"])
      expect(data_object.manufacturer).to eq(valid_row["manufacturer"])
      expect(data_object.price).to eq(BigDecimal.new(valid_row["price"]))
      expect(data_object.used).to eq(valid_row["used"])
      expect(data_object.note).to eq(valid_row["note"])
    end

  end

  it "returns error object" do
    validator = CarImport::Validators::RowValidator.new(row: invalid_row, line: 7)

    validator.on_success do |data_object|
      callable_double.test
    end

    expect(callable_double).not_to receive(:test)

    validator.on_error do |error_object|
      expect(error_object.line).to eq(7)
      expect(error_object.messages[:manufacturer]).to eq(["can't be blank"])
      expect(error_object.messages[:price]).to eq(["is not a number"])
    end
  end

end
