require "rails_helper"

describe CarImport::Validators::ColumnValidator do

  let(:valid_headers) { ["id", "manufacturer", "price", "used"] }

  it "should not return any missing columns" do
    expect(CarImport::Validators::ColumnValidator.call(valid_headers)).to eq([])
  end

  it "should return all columns" do
    expect(CarImport::Validators::ColumnValidator.call([])).to eq(valid_headers)
  end

  it "should return 'id' and 'used'" do
    invalid_headers = valid_headers - ["manufacturer", "price"]
    expect(CarImport::Validators::ColumnValidator.call(invalid_headers)).to eq(["manufacturer", "price"])
  end

  it "should return 'manufacturer' and 'price'" do
    invalid_headers = valid_headers - ["id", "used"]
    expect(CarImport::Validators::ColumnValidator.call(invalid_headers)).to eq(["id", "used"])
  end

end
