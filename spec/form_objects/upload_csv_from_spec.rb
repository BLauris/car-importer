require "rails_helper"

describe UploadCsvFrom do

  context "sad path" do
    let(:wrong_format_file_path) { "#{Rails.root}/spec/fixtures/its_a_bit_slow.png" }
    let(:wrong_format_file) { Rack::Test::UploadedFile.new(wrong_format_file_path, 'image/png', true) }
    let(:missing_columns_file_path) { "#{Rails.root}/spec/fixtures/missing_columns_example.csv" }
    let(:missing_columns_file) { Rack::Test::UploadedFile.new(missing_columns_file_path, 'text/csv', true) }

    it "returns no file error" do
      form_object = UploadCsvFrom.new(file: "")
      form_object.save

      expect(form_object.errors.messages[:file]).to include("can't be blank")
    end

    it "returns wrong file format error" do
      form_object = UploadCsvFrom.new(file: wrong_format_file)
      form_object.save

      expect(form_object.errors.messages[:file]).to include("Invalid file format, allowed only CSV")
    end

    it "returns missing columns error" do
      form_object = UploadCsvFrom.new(file: missing_columns_file)
      form_object.save

      expect(form_object.errors.messages[:file]).to include("CSV File has some missing columns: price and used")
    end
  end

  context "happy path" do
    let(:path) { "#{Rails.root}/spec/fixtures/example.csv" }
    let(:file) { Rack::Test::UploadedFile.new(path, 'text/csv', true) }

    it "saves import recird" do
      form_object = UploadCsvFrom.new(file: file)

      expect{ form_object.save }.to change { ImportRecord.count }.by(1)
      expect(form_object.errors.blank?).to eq(true)
    end
  end

end
