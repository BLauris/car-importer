require "rails_helper"

describe UploadCsvFrom do
  let(:file) { File.open("#{Rails.root}/spec/fixtures/example.csv") }
  let(:prepared_data) { PreparedImportRecord.new(file) }
  let(:presenter) { ImportPreviewPresenter.new(import_record_id: prepared_data.import_record.id) }

  before do
    presenter.validate_rows
  end

  it "returns correct total row count" do
    expect(presenter.total_count).to eq(11)
  end

  it "returns valid row count" do
    expect(presenter.valid_count).to eq(4)
  end

  it "returns invalid row count" do
    expect(presenter.invalid_count).to eq(7)
  end

  context "invalid rows" do
   it "correct errors for line 3" do
     row = presenter.invalid_rows.first

     expect(row.line).to eq(3)
     expect(row.messages[:manufacturer]).to eq(["can't be blank"])
   end

   it "correct errors for line 4" do
     row = presenter.invalid_rows.second

     expect(row.line).to eq(4)
     expect(row.messages[:price]).to eq(["can't be blank", "is not a number"])
   end

   it "correct errors for line 5" do
     row = presenter.invalid_rows.third

     expect(row.line).to eq(5)
     expect(row.messages[:manufacturer]).to eq(["can't be blank"])
     expect(row.messages[:used]).to eq(["Must be a boolean value 'true' or 'false'"])
   end

   it "correct errors for line 7" do
     row = presenter.invalid_rows.fourth

     expect(row.line).to eq(7)
     expect(row.messages[:price]).to eq(["can't be blank", "is not a number"])
   end

   it "correct errors for line 8" do
     row = presenter.invalid_rows.fifth

     expect(row.line).to eq(8)
     expect(row.messages[:manufacturer]).to eq(["can't be blank"])
     expect(row.messages[:price]).to eq(["can't be blank", "is not a number"])
     expect(row.messages[:used]).to eq(["Must be a boolean value 'true' or 'false'"])
   end

   it "correct errors for line 10" do
     row = presenter.invalid_rows[5]

     expect(row.line).to eq(10)
     expect(row.messages[:price]).to eq(["must be greater than or equal to 0"])
   end

   it "correct errors for line 11" do
     row = presenter.invalid_rows.last

     expect(row.line).to eq(11)
     expect(row.messages[:price]).to eq(["is not a number"])

   end

  end

  context "valid rows" do
    it "correct data for id 1" do
      row = presenter.valid_rows.first

      expect(row.id).to eq("1")
      expect(row.manufacturer).to eq("Honda")
      expect(row.note).to eq(nil)
      expect(row.price).to eq(BigDecimal.new("1340.0"))
      expect(row.used).to eq("FALSE")
    end

    it "correct data for id 3" do
      row = presenter.valid_rows.second

      expect(row.id).to eq("3")
      expect(row.manufacturer).to eq("Skoda")
      expect(row.note).to eq("cool car")
      expect(row.price).to eq(BigDecimal.new("120.0"))
      expect(row.used).to eq("TRUE")
    end

    it "correct data for id 7" do
      row = presenter.valid_rows.third

      expect(row.id).to eq("7")
      expect(row.manufacturer).to eq("Skoda")
      expect(row.note).to eq("cool car")
      expect(row.price).to eq(BigDecimal.new("300.0"))
      expect(row.used).to eq("TRUE")
    end

    it "correct data for id 10" do
      row = presenter.valid_rows.last

      expect(row.id).to eq("10")
      expect(row.manufacturer).to eq("Ferrari")
      expect(row.note).to eq("Expensive")
      expect(row.price).to eq(BigDecimal.new("10000.0"))
      expect(row.used).to eq("FALSE")
    end

  end

end
