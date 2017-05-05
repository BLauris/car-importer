require "rails_helper"

describe CarImport::Worker do

  let(:file) { File.open("#{Rails.root}/spec/fixtures/example.csv") }
  let(:prepared_data) { PreparedImportRecord.new(file) }

  it "creates or updates 'car' records from valid csv rows" do
    expect {
      CarImport::Worker.call!(prepared_data.import_record.id)
    }.to change { Car.count }.by(4)
  end

end
