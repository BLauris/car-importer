require "rails_helper"

describe UploadCsvFrom do

  context "sad path" do
    let(:wrong_format_file) { File.open("#{Rails.root}/spec/fixtures/its_a _bit_slow.png")  }
    let(:missing_columns_file) { File.open("#{Rails.root}/spec/fixtures/missing_columns_example.csv") }

    it "returns no file error" do
      form_object = UploadCsvFrom.new(file: "")
      form_object.save

      expect(form_object.errors.messages[:file]).to include("can't be blank")
    end

    xit "returns wrong file format error" do
      form_object = UploadCsvFrom.new(file: wrong_format_file)
      form_object.save

      expect(form_object.errors.messages[:file]).to include("CSV File has some missing columns: price and used")
    end

    it "returns missing columns error" do
      form_object = UploadCsvFrom.new(file: missing_columns_file)
      form_object.save

      expect(form_object.errors.messages[:file]).to include("CSV File has some missing columns: price and used")
    end
  end

  context "happy path" do
    let(:valid_file) { File.open("#{Rails.root}/spec/fixtures/example.csv") }

    it "saves import recird" do
      form_object = UploadCsvFrom.new(file: valid_file)

      expect{ form_object.save }.to change { ImportRecord.count }.by(1)
      expect(form_object.errors.blank?).to eq(true)
    end
  end

end
